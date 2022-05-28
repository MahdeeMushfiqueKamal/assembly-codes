.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH     
line1 DB "Enter the 1st number:  $"
line2 DB "Enter the 2nd number:  $"
line3 DB "Enter the 3rd number:  $"

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
    MOV BL, AL  ;BL has first number
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H   
    
    ;PRINTING THE 2nd LINE
    LEA DX, line2
    MOV AH, 9
    INT 21H   
    
    ;INPUTING A CHARACTER
    MOV AH, 1
    INT 21H
    MOV BH, AL  ;BH has 2nd number
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H
    
    
    ;PRINTING THE 3rd LINE
    LEA DX, line1
    MOV AH, 9
    INT 21H   
    
    ;INPUTING A CHARACTER
    MOV AH, 1
    INT 21H
    MOV CL, AL  ;CL has 3rd number
    
    ;PRINTING NEW LINE
    MOV DL, CR
    MOV AH, 2
    INT 21H 
    MOV DL, LF
    INT 21H     
    
    ;COMPARISON
    CMP BL,BH
    JGE OUTER_IF   
    JMP OUTER_ELSE
    
    OUTER_IF:
        ;BL BORO  
        CMP BL,CL
        JGE INNER_IF1
        JMP INNER_ELSE1
    
    OUTER_ELSE:
        ;BH BORO  
        CMP BH, CL
        JGE INNER_IF2
        JMP INNER_ELSE2
    
    INNER_IF1:
        ;PRINTING A CHARACTER
        MOV DL, BL
        MOV AH, 2
        INT 21H  
        JMP END_OUTER_IF
    
    INNER_ELSE1:
        MOV DL, CL
        MOV AH, 2
        INT 21H  
        JMP END_OUTER_IF
    
    
    INNER_IF2:
        ;PRINTING A CHARACTER
        MOV DL, BH
        MOV AH, 2
        INT 21H  
        JMP END_OUTER_IF
    
    INNER_ELSE2:
        MOV DL, CL
        MOV AH, 2
        INT 21H  
        JMP END_OUTER_IF
        
    END_OUTER_IF:      
             
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
