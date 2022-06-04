.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
N DW ?  
I DW ?
IS_NEGATIVE DB ?  
ARR DW 100 DUP(0)
line1 DB "Enter N:  $" 
line2 DB "Sorted Array:  $"

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
    JMP START   
    
    END_PROGRAM:         
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP 

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
    
END MAIN