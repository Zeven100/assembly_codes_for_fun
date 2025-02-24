# assembly code for factorial calculation 
.data 
num : .word 4

.text
.globl main

main :

# loading the number 
lw $t0 , num

# put 1 in a register
li $t1 , 1

# for loop till number becomes zero
loop :
beqz $t0 , print
mul $t1 , $t1 , $t0
addi $t0 , $t0 , -1
j loop

print:

# put the number in the a0 register
move $a0 , $t1
li $v0 , 1
syscall

li $v0 , 10
syscall