from math import *
import sys
def OppCodeConverter(ins):
    if ins == "add":
        return "1000"
    elif ins == "addi":
        return "0011"
    elif ins == "sub":
        return "0000"
    elif ins == "subi":
        return "0111"
    elif ins == "and":
        return "0101"
    elif ins == "andi":
        return "1110"
    elif ins == "or":
        return "1001"
    elif ins == "ori":
        return "0110"
    elif ins == "sll":
        return "0001"
    elif ins == "srl":
        return "1011"
    elif ins == "nor":
        return "1101"
    elif ins == "lw":
        return "0100"
    elif ins == "sw":
        return "0010"
    elif ins == "beq":
        return "1111"
    elif ins == "bne":
        return "1010"
    elif ins == "j":
        return "1100"
    else:
        print("Instruction ",ins,"can not be converted")
        sys.exit()

def RegisterConverter(res):
    if res == "$zero":
        return "0000"
    elif res == "$t0":
        return "0001"
    elif res == "$t1":
        return "0010"
    elif res == "$t2":
        return "0011"
    elif res == "$t3":
        return "0100"
    elif res == "$t4":
        return "0101"
    elif res == "$sp":
        return "0110"
    else:
        print("Resister",res,"can not be converted")
        sys.exit()

def ShamtRegisterConverter(token):
    parts = token.split("(")
    shamt = int(parts[0])
    shamt = bin(shamt).replace("0b", "")
    while len(shamt) < 4:
        shamt = "0"+shamt
    resister = parts[1].replace(")","").strip()
    return RegisterConverter(resister),shamt



# decimal to binary --> 
def ConvertNumber(decNum):
    isNeg = True if decNum[0]=='-' else False
    if isNeg:
        absNum = abs(int(decNum[1:]))
        if(absNum) > 8:
            print("Number",decNum,"is too large to be converted")
            sys.exit()
        absNum = 15 - absNum + 1
        finalNum = bin(absNum).replace("0b", "")
    else:
        # positive number
        finalNum = int(decNum)
        if(finalNum) > 7:
            print("Number",decNum,"is too large to be converted")
            sys.exit()
        finalNum = bin(finalNum).replace("0b", "")
        while len(finalNum) < 4:
            finalNum = "0"+finalNum
    return finalNum