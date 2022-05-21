.model small

.stack 100H

.data
cr equ 0DH
lf equ 0AH

.code

main proc
    ;data segment initialization. copy data to DS
    mov ax, @data
    mov ds, ax
    
    ;dos exit 
    mov AH, 4CH
    int 21h
    
main endp
end main



