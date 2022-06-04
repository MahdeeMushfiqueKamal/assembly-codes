.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
;binary search data
X DW 8  
L DW ?
R DW ?
MID DW ? 
not_found_str DB "Not found $" 
found_str DB "Found at $"          
;binary search data ends

N DW 9
ARR DW 0,1,2,2,4,6,8,9,9
line DB "Enter a Character:  $"

.CODE
MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS, AX
    
    CALL BINARY_SEARCH           
             
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
        JMP END_SEARCH
    
    NOT_FOUND:
        LEA DX, not_found_str
        MOV AH, 9
        INT 21H     
    END_SEARCH:
    RET
BINARY_SEARCH ENDP  




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
              
              
              