.MODEL SMALL 
.STACK 100H 
.DATA

N DW ?
CR EQU 0DH
LF EQU 0AH  
LINE DB "INVAID INPUT$"

.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
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
    
    END_INPUT_LOOP:
    MOV N, BX
    
    ; printing CR and LF
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    
    
    ;------------------------------------
    ; start from here
    ; input is in N
    
    
    MOV CX, N 
    CMP CX, 0       ;LESS THAN ZERO
    JL INVALID
    
    CMP CX, 100
    JG INVALID      ; GREATER THAN 100
    
    CMP CX,80
    JGE APLUS
    
    CMP CX,75
    JGE A
    
    CMP CX,70
    JGE AMINUS
    
    CMP CX,65
    JGE BPLUS
    
    CMP CX,60
    JGE B
    
    JMP F
    
    APLUS:        
        ;PRINTING A CHARACTER
        MOV DL, 65
        MOV AH, 2
        INT 21H
        MOV DL, 43
        MOV AH, 2
        INT 21H
        JMP END_IF      
    A:        
        ;PRINTING A CHARACTER
        MOV DL, 65
        MOV AH, 2
        INT 21H
        JMP END_IF 
    
    AMINUS:       
        ;PRINTING A CHARACTER
        MOV DL, 65
        MOV AH, 2
        INT 21H
        MOV DL, 45
        MOV AH, 2
        INT 21H
        JMP END_IF
    BPLUS:        
        ;PRINTING A CHARACTER
        MOV DL, 66
        MOV AH, 2
        INT 21H
        MOV DL, 43
        MOV AH, 2
        INT 21H
        JMP END_IF  
    B:        
        ;PRINTING A CHARACTER
        MOV DL, 66
        MOV AH, 2
        INT 21H
        JMP END_IF 
    F:        
        ;PRINTING A CHARACTER
        MOV DL, 70
        MOV AH, 2
        INT 21H
        JMP END_IF
    INVALID:
        ;PRINTING THE FIRST LINE
        LEA DX, line
        MOV AH, 9
        INT 21H 
    
    
    END_IF:  

	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 

