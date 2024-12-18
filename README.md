# calculator_nasm_linux
Calculator on Assembly language, NASM dialect

#Download NASM

sudo apt -y install nasm


#Check NASM version

nasm -v


#Assembling 

nasm -f elf64 calculator_nasm_linux.asm -o output.o


#Create executive file

ld -o run_program output.o


#Run file

./run_program
