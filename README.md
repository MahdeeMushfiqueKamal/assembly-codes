## 8086 Assembly Language 

## Internal Architecture of 8086 Microprocessor
![](/Arch_8086.png)

#### General Purpose Resisters:

The 8086 microprocessor has 8 registers AH, AL, BH, BL, CH, CL, DH, DL. \
Individually, these registers can store 8-bit(1 byte) data, and in pairs, they can store 16-bit(2 byte) data. \
AX, BX, CX, DX

- AX = Accumulator register (Used for I/O)
- BX = Base register (used to store the starting base address of the memory field)
- CX = Counter resister
- DX = Data resister


#### Segment Resisters:

8086 microprocessor has 4 segment buses i.e. CS, DS, SS & ES

- CS = Code Segment Register
- DS = Data Segment Register
- SS = Stack Segment Register
- ES = Extra Segment Register

#### Special Purpose Resister:

- IP = Instruction pointer


#### Basic Template
```assembly
.MODEL SMALL
.STACK 100H

.DATA 
CR EQU 0DH
LF EQU 0AH

.CODE
MAIN PROC
    ;DATA SEGMENT INITIALIZATION, COPY DATA TO DS
    MOV AX,@DATA
    MOV DS, AX


    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
```

#### Exiting 

keep `4CH` on `AH` and call interupt routine `21H`

```assembly
;DOS EXIT
MOV AH, 4CH
INT 21H
```

#### Defining a data

- DB stands for defined byte. (1 byte)
- DW stands for define word. (2 byte)
- `X DB 65` sets the value of X = 'A'
- `Y DB ?` sets the value of Y undefined
- 'Hello world!!$' is a string where each letter is 1 byte/2 bytes defined by DB/DW

```assembly
HW DB 'Hello world!!$'
BW DB 'Bye World!!$'
X DB 65     
Y DB ? 
```

