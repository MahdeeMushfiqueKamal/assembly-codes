.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
X DB ?
Y DB ?
Z DB ?  
line1 DB "Enter 1st Character:  $"
line2 DB "Enter 2nd Character:  $"
line3 DB "Enter 3rd Character:  $"
star7 DB "*******$"
star3 DB "***$" 
star2 DB "**$"

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
    
    ;INPUTING A CHARACTER
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
    
    ;PRINTING THE 3rd LINE
    LEA DX, line3
    MOV AH, 9
    INT 21H   
    
    ;INPUTING A CHARACTER
    MOV AH, 1
    INT 21H
    MOV Z, AL
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H
    
    ; printing starts 
    ;PRINTING THE 7* LINE
    LEA DX, star7
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H    
    ;line 2
    ;PRINTING THE 7* LINE
    LEA DX, star7
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H    
    ;line 3 
    ;PRINTING THE 3* 
    LEA DX, star3
    MOV AH, 9
    INT 21H  
    ;PRINTING X CHARACTER
    MOV DL, Y
    MOV AH, 2
    INT 21H 
    ;PRINTING THE 3* 
    LEA DX, star3
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H    
    ;line 4
    ;PRINTING star2 CHARACTER
    LEA DX, star2
    MOV AH, 9
    INT 21H
    ;PRINTING X CHARACTER
    MOV DL, X
    MOV AH, 2
    INT 21H  
    ;PRINTING Y CHARACTER
    MOV DL, Y
    MOV AH, 2
    INT 21H
    ;PRINTING Z CHARACTER
    MOV DL, Z
    MOV AH, 2
    INT 21H
    ;PRINTING star2 CHARACTER
    LEA DX, star2
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H 
    ;line 5
    ;PRINTING THE 4* 
    LEA DX, star3
    MOV AH, 9
    INT 21H  
    ;PRINTING Z CHARACTER
    MOV DL, Z
    MOV AH, 2
    INT 21H 
    ;PRINTING THE 4* 
    LEA DX, star3
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H    
    ;line 6
    ;PRINTING THE 7* LINE
    LEA DX, star7
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H    
    ;line 7
    ;PRINTING THE 7* LINE
    LEA DX, star7
    MOV AH, 9
    INT 21H
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    MOV AH, 2
    INT 21H
    ;printing ends
    
          
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
