.data
prompt1: .asciiz "enter val1\n"
prompt2: .asciiz "enter val2\n"
prompt3: .asciiz "enter val3\n"
result:  .asciiz "the sum is: " 

.text
#prompt 1 to screen 
li $v0 4
la $a0 prompt1
syscall

#read val1
li $v0 5
syscall
move $s0 $v0

#prompt 2 to screen
li $v0 4
la $a0 prompt2
syscall

#read val 2
li $v0 5
syscall
move $s1 $v0

#begin calculating sum store in $s0
add $s0 $s0 $s1

#prompt 3
li $v0 4
la $a0 prompt3
syscall

#read val 3
li $v0 5
syscall

#finish adding to sum 
add $s0 $v0 $s0

#print result
li $v0 4
la $a0 result
syscall
li $v0 1
move $a0 $s0
syscall

#close the program
li $v0 10
syscall