;printing hello world
.model small
.stack 100H

.data
    cr equ 0DH
    lf equ 0AH
    hw db 'Hello world!!$'
    bw db 'Bye World!!$'     
    ;db stands for defined byte, dw stands for define word. 16 byte
    ;here each letter is 1 byte
    x db ? ; undefined variable
.code

main proc
    ;data segment initialization. copy data to DS
    mov ax, @data
    mov ds, ax
    
    lea dx, hw
    mov AH, 9 
    int 21h
    ;lea stands for load effective address.It states the start of the string to be printed 
    ; for value 9 in AH, interupt routine 21 prints things in lea. 
    
    lea dx, bw
    mov ah,9
    int 21h
    
    ;dos exit 
    mov AH, 4CH
    int 21h
    
main endp
end main



