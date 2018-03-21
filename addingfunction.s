 #running sum prgram by jk4057
#this program demonstrates function calls in mips. it has the user enter 2 ints at start and calculates sum. then the user can
#keep entering numbers to add to sum or enter 0 to quit

.data 
    prompt1: .asciiz "enter value 1 : "
    prompt2: .asciiz "enter value 2 : "
    sum:     .asciiz "sum is currently : "
    prompt3: .asciiz "enter val  to be added to sum or enter 0 to quit: "
    newline: .asciiz "\n"
    
    


.text
main:
#set sum = 0 and print
li $s0, 0	# set sum in $s0 = 0
li $v0, 4       # system command to print %s  
la $a0, sum     # load "sum" string into $a0
syscall		# print contents of $a0 with is "sum" string
li $v0, 1	# system command to print int
move $a0, $s0   # load contents of $s0 into $a0 (remembr $s0 holds value of current sum)
syscall		# print the integer sum
li $v0, 4	# system call for printing string
la $a0, newline # laods newline
syscall		# prints newline


# get number 1
li $v0, 4        # system command to print
la $a0, prompt1  # load the adress of string "prompt1" into register a0  
syscall          # call the print with string passed
li $v0, 5        # system command to read int input
syscall          # will read user input and store the value entered into register v0
move $a1 $v0     # moves content of v0 into a1 to be used as argument for add function

#get number 2
li $v0, 4	# all of these instructions identicle to the ones above for number 1
la $a0, prompt2
syscall
li $v0, 5
syscall
move $a2, $v0

loop:		#this is the portion of code that repeats until user enters 0
jal addnums	# jumps to addnums function and stores address of next line in $ra so it can return(at this point we begin running add)
move $a1 $s0	# (at this point add retruns) moves contents of $s0(current sym) into $a1 
li $v0, 4	# system command to print string
la $a0, prompt3	# loads prompt3 into a0
syscall		# prints prompt 3
li $v0, 5	# system command for reading int
syscall		# reads int into v0
move $a2 $v0    # moves user input from v0 into a2

bne $a2 $zero loop # if the uswes input is not 0 then return to the beginnning of loop

#exit if 0 is entered
li $v0, 10	#system command for exiting a program
syscall		# exits the program

addnums:
# add the numbers and print the new sum
add $s0, $a1, $a2	# adds contents of a1 and a2 and stores in $s0
li $v0, 4		# system command to print string
la $a0, sum		# loads sum message into a0
syscall			# prints sum message
li $v0, 1		# system command to print int
move $a0, $s0		# moves value of s0(current sum) into a0
syscall			# prints current sum
li $v0, 4		# system command to print string
la $a0, newline		#loads newline into a0
syscall			# prints new line

jr $ra			#returns back to the adress stored in ra (the line after jal)
