.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
N DW ?  
I DW ? 
J DW ?
KEY DW ?
IS_NEGATIVE DB ?   
ARR_I DW ?
ARR DW 100 DUP(0)
line1 DB "Enter N:  $" 
line2 DB "Sorted Array:  $"   
LINE3 DB "Enter the number you are looking for (X for discard search): $"

;binary search data
X DW 8  
L DW ?
R DW ?
MID DW ? 
not_found_str DB "Not found $" 
found_str DB "Found at $"          
;binary search data ends

.CODE
MAIN PROC 
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS, AX
    
    Start:
    ;PRINTING THE FIRST LINE
    LEA DX, line1
    MOV AH, 9
    INT 21H   
    
    CALL INPUT_A_NUM
    MOV N, BX
    CALL NEWLINE  
    
    ;CHECKING IF THE NUMBER IS >= 0
    CMP N, 0 
    JLE END_PROGRAM
    
    ;inputting the array
    MOV CX, N
    MOV I, CX     
    LEA SI, ARR
    
    ARRAY_INPUT:    
        CMP I, 0
        JZ END_ARRAY_INPUT    
        
        CALL INPUT_A_NUM
        MOV [SI], BX
        ADD SI, 2
        ;DEC I
        MOV CX, I
        DEC CX
        MOV I, CX 
        CALL NEWLINE 
        JMP ARRAY_INPUT
    END_ARRAY_INPUT:    
    
    CALL INSERTION_SORT
    
    ;OUTPUTTING the array
    ;PRINTING THE 2ND LINE
    LEA DX, line2
    MOV AH, 9
    INT 21H 
    
    ;COPY N TO I
    MOV CX, N
    MOV I, CX     
    LEA SI, ARR
    
    ARRAY_OUTPUT:    
        CMP I, 0
        JZ END_ARRAY_OUTPUT    
                
        MOV AX,[SI]
        CALL PRINT_DIGITS
        ADD SI, 2
        ;DEC I
        MOV CX, I
        DEC CX
        MOV I, CX 
        CALL SPACE 
        JMP ARRAY_OUTPUT
    END_ARRAY_OUTPUT:    
    CALL NEWLINE  
    CALL NEWLINE 
    
    STEP6:
    ;TAKE INPUT FROM USER AND DO BINARY SEARCH 
    LEA DX, line3
    MOV AH, 9
    INT 21H
    
    CALL INPUT_A_NUM
    MOV X, BX
    CALL NEWLINE 
    
    CMP X, 8H
    JE END_STEP6
    
    CALL BINARY_SEARCH  
    
    JMP STEP6:
    END_STEP6:
    CALL NEWLINE 
    CALL NEWLINE
    JMP START   
    END_PROGRAM:         
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP 

BINARY_SEARCH PROC
    ; L=0, R = N-1
    MOV L, 0
    MOV CX, N
    DEC CX
    MOV R, CX
    
    SEARCH:        
        ;MID = (L+R)/2
        XOR CX, CX
        ADD CX, L
        ADD CX, R
        SHR CX , 1 
        MOV MID, CX  
        
        SHL CX, 1
        MOV SI, 0 
        ADD SI, CX
        
        ; EXIT CASE 
        MOV CX, R
        CMP L,CX
        JG NOT_FOUND 
        
        MOV CX, X
        CMP CX,ARR[SI]
        JE FOUND
        JL LEFT
        JG RIGHT
        
    LEFT:  
        MOV CX, MID
        DEC CX
        MOV R, CX
        JMP SEARCH
    
    RIGHT:        
        MOV CX, MID
        INC CX
        MOV L, CX
        JMP SEARCH
         
    
    FOUND: 
        ;PRINTING THE FIRST LINE
        LEA DX, FOUND_STR
        MOV AH, 9
        INT 21H  
        
        MOV AX, MID
        CALL PRINT_DIGITS 
        CALL NEWLINE 
        JMP END_SEARCH
    
    NOT_FOUND:
        LEA DX, not_found_str
        MOV AH, 9
        INT 21H 
        CALL NEWLINE    
    END_SEARCH:
    RET
BINARY_SEARCH ENDP 

;INSERTION SORT
INSERTION_SORT PROC   
    MOV SI, 0  
    MOV J, 1
    OUTER_LOOP:
        ;EXIT CASE J==N : EXIT
        MOV CX, N
        CMP J,CX
        JE END_OUTER_LOOP
        ; INSIDE THE OUTER LOOP   
        
        ; KEY = A[J] 
        MOV CX, J
        SHL CX, 1
        MOV SI, 0
        ADD SI, CX 
        MOV BX, ARR[SI]
        MOV KEY, BX  
        ;LEA SI, ARR        
        MOV SI, 0
        ; I = J -1 
        MOV CX, J
        DEC CX
        MOV I, CX  
        
        INNER_WHILE_LOOP:  
            CMP I,0
            JL END_INNER_WHILE_LOOP
            ;ARR[I] >= KEY : END WHILE
            MOV CX, I
            SHL CX, 1
            ;LEA SI, ARR
            MOV SI, 0
            ADD SI, CX 
            MOV BX, ARR[SI]  ; BX = ARR[I] 
            CMP BX,KEY
            JLE END_INNER_WHILE_LOOP
            
            ;INSIDE WHILE LOOP
            MOV ARR_I, BX
            ;ARR[I+1] = ARR[I]  
            MOV CX, I
            INC CX         ; CX = I+1
            SHL CX, 1   
            ;LEA SI, ARR
            MOV SI, 0
            ADD SI, CX  
            MOV BX, ARR_i
            MOV ARR[SI], BX 
            
            ; I = I -1 
            MOV BX, I
            DEC BX
            MOV I, BX
            
            JMP INNER_WHILE_LOOP            
            ;END WHILE             
                        
        
        END_INNER_WHILE_LOOP:
        ;BEFORE ENDING FOR LOOP
        ; ARR[I+1] = KEY
        MOV CX, I
        INC CX         ; CX = I+1
        SHL CX, 1  
        ;LEA SI, ARR
        MOV SI, 0
        ADD SI, CX     
        MOV BX, KEY
        MOV ARR[SI], BX ; ARR[I+1] = KEY
        
        ; LAST E J BARABO
        MOV CX, J
        INC CX
        MOV J, CX  
        JMP OUTER_LOOP
    END_OUTER_LOOP:
    RET
INSERTION_SORT ENDP     

; inputs a number to BX , uses AX, CX
INPUT_A_NUM PROC
    MOV IS_NEGATIVE, 0
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE PROCESS_NEG_NUMBER
    CMP AL, LF
    JE PROCESS_NEG_NUMBER 
    CMP AL, '-'
    JE CHANGE_IS_NEGATIVE
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    CHANGE_IS_NEGATIVE:
        MOV IS_NEGATIVE, 1 
        JMP INPUT_LOOP
    
    PROCESS_NEG_NUMBER:
        ;MOV CX, IS_NEGATIVE
        CMP IS_NEGATIVE, 0
        JE END_INPUT_LOOP
        
        MOV CX, 0
        SUB CX, BX
        MOV BX, CX
    
    END_INPUT_LOOP:
    RET
INPUT_A_NUM ENDP


;PRINT DIGITS OF AX  , USES CX,DX,BX
PRINT_DIGITS PROC 
    ;initialize count
    MOV CX,0
    MOV DX,0
    
    ;CHECKING IS THE NUMBER IS ZERO
    CMP AX, 0
    JE ZERO_CASE
             
    ; CHECKING IF THE NUMBER IS positive 
    CMP AX, 0
    JG PUSHING
             
    ; THE NUMBER IS NEG
    MOV BX, AX
    MOV DL, '-'
    MOV AH,2
    INT 21h         
    MOV AX, BX
    NEG AX      
    ;initialize count
    MOV CX,0
    MOV DX,0
    ;ADD AX, 1 
    
    PUSHING:
        ; if ax is zero
        CMP AX,0
        JE POPPING     
         
        ;initialize bx to 10
        MOV BX,10       
         
        ; extract the last digit
        DIV BX                 
         
        ;push it in the stack
        PUSH DX             
         
        ;increment the count
        INC CX             
         
        ;set dx to 0
        XOR DX,DX
        JMP PUSHING
    
    POPPING:
        ;check if count is greater than zero
        CMP CX,0
        JE EXIT
         
        ;pop the top of stack
        POP DX         
        ;add 48 so that it represents the ASCII value of digits
        ADD DX,48
         
        ;interrupt to print a character
        MOV AH,2
        INT 21h
         
        ;decrease the count
        DEC CX
        JMP POPPING
    
    ZERO_CASE:  
        MOV DL, 48
        MOV AH,2
        INT 21h
    EXIT:
    RET
PRINT_DIGITS ENDP

;PRINTING NEW LINE PROCEDURE, USES DL, AH
NEWLINE PROC    
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H  
    RET
NEWLINE ENDP    

;PRINTING SPACE
SPACE PROC     
    ;PRINTING A CHARACTER
    MOV DL, ' '
    MOV AH, 2
    INT 21H 
    RET
SPACE ENDP
    
END MAIN
