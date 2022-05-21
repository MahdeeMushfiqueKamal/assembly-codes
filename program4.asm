; adding 2 one digit numbers
.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
X DB ?
Y DB ? 
SUM DB ?
line1 DB "Enter a number:  $"
line2 DB "Enter another number:  $"

.CODE
MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS, AX
    
    ;PRINTING THE FIRST LINE
    LEA DX, line1
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
    MOV AH, 2
    INT 21H
    
    ;PRINTING THE 2nd LINE
    LEA DX, line2
    MOV AH, 9
    INT 21H   
    
    ;INPUTING 2nd CHARACTER
    MOV AH, 1
    INT 21H
    MOV Y, AL 
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H 
    
    ;The addition
    MOV BL,X
    MOV BH,Y 
    ADD BL , BH
    SUB BL, 30H
    MOV SUM, BL
    
    ;PRINTING RESULT
    MOV DL, SUM
    MOV AH, 2
    INT 21H       
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
