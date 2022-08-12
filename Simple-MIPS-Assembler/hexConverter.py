#to run: python hexConverter.py input.txt output.txt
import sys
from SupportFunctions import *

def hexConverter(ins):
    if ins == "0000":
        return "0"
    elif ins == "0001":
        return "1"
    elif ins == "0010":
        return "2"
    elif ins == "0011":
        return "3"
    elif ins == "0100":
        return "4"
    elif ins == "0101":
        return "5"
    elif ins == "0110":
        return "6"
    elif ins == "0111":
        return "7"
    elif ins == "1000":
        return "8"
    elif ins == "1001":
        return "9"
    elif ins == "1010":
        return "a"
    elif ins == "1011":
        return "b"
    elif ins == "1100":
        return "c"
    elif ins == "1101":
        return "d"
    elif ins == "1110":
        return "e"
    elif ins == "1111":
        return "f"
    else:
        return ""

if len(sys.argv) < 2:
    print("Input filename is not provided")
    sys.exit()
if len(sys.argv) < 3:
    print("Output filename is not provided")
    sys.exit()
elif len(sys.argv) > 3:
    print("Too many argument for filename is provided")
    sys.exit()

infilename = sys.argv[1]
infile = open(infilename,'r')

outfilename = sys.argv[2]
outfile = open(outfilename,'w')


lines = infile.readlines()
outfile.write("v2.0 raw\n")
for line in lines:
    hexa = line.strip().split(" ")

    write = ""
    for i in hexa:
        write += hexConverter(i)
    outfile.write(write) 
    outfile.write("\n")


infile.close()
outfile.close()
