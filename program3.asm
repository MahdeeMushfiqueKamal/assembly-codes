;inputing a character and printing corresponding output character
.model small
.stack 100H

.data
    cr equ 0DH
    lf equ 0AH
    x db ? ; undefined variable
.code

main proc
    ;data segment initialization. copy data to DS
    mov ax, @data
    mov ds, ax
    
    mov ah, 1
    int 21h
    mov x, al
           
    add x, 33
           
    mov dl, x
    mov ah, 2
    int 21h
    
    ;dos exit 
    mov AH, 4CH
    int 21h
    
main endp
end main



