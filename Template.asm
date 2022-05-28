.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
X DB ?
line DB "Enter a Character:  $"

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
    MOV X, AL
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H
    
    ;PRINTING A CHARACTER
    MOV DL, X
    MOV AH, 2
    INT 21H           
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
