.data
result: .asciiz "the result was: "

.text
# load data into registers
li $s0,1
li $s1, 2
li $s2, 3
li $s3, 4
li $s4, 5
li $s5, 6

bne $s4, $s5 Else #if s4 != s5 go to the else statement

If:
add $s0 $s1 $s2
j Exit

Else:
sub $s0, $s1,$s2

Exit:
li $v0 4
la $a0 result
syscall
li $v0 1
move $a0 $s0
syscall
li $v0 10
syscall

