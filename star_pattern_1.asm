.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
X DB ?
I DB ?
line DB "Enter a Number:  $"  
star DB 42

.CODE
MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS, AX
    
    ;PRINTING THE FIRST LINE
    LEA DX, line
    MOV AH, 9
    INT 21H   
    
    ;INPUTING A CHARACTER
    MOV AH, 1
    INT 21H   
    AND AL, 0FH
    MOV X, AL
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H
    
    MOV BL,1
    OUTER_FOR_LOOP:     
        MOV BH,0
        ;PRINTING A line
        INNER_FOR_LOOP:
            MOV DL, star
            MOV AH, 2
            INT 21H
            INC BH
            CMP BH, BL
            JL INNER_FOR_LOOP 
        
        ;PRINTING NEW LINE
        MOV DL, CR
        MOV AH, 2
        INT 21H 
        MOV DL, LF
        INT 21H
        INC BL
        CMP BL,X
        JLE OUTER_FOR_LOOP
                 
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
