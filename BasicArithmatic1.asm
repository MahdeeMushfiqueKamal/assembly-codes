; Z = X-2Y
.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     

.CODE
MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS, AX
    
    ;INPUTING A NUMBER
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV CL, AL  ;CL HOLDS THE VALUE OF X 
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H 
    
    ;INPUTING ANOTHER NUMBER
    MOV AH, 1
    INT 21H
    SUB AL, 30H     ; AL HOLDS THE VALUE OF Y 
   
    
    ;DOING ARITHMATICS
    SUB CL, AL
    SUB CL, AL 
    ADD CL, 30H
    
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H
    ;PRINTING A CHARACTER
    MOV DL, CL
    MOV AH, 2
    INT 21H           
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN