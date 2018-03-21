#program by jk4057, demonstrates saving value from s register onto stack so that s register can be used in function, 
# then reloads s register with original content upon returning to main


.data
    promptMain:  .asciiz "enter a number to be displayed only in main: "
    promptFunction: .asciiz "enter a number to store in $s0 and print from this function or enter 0 to quit : "
    newline: .asciiz "\n"
    mainResult: .asciiz "the value of $s0 in main is : "
    functionResult: .asciiz "the value of $s0 in the scope of this function is: "



.text
    # promt for value of $s0 in main (this should never change any time you print from main)
    main:
        li $v0, 4		
        la $a0, promptMain
        syscall
        li $v0, 5
        syscall
        move $s0 , $v0
       
    # this loop simply prints the value of $s0 as it should apear in main, its only purpose is to show the value of $s0 in main is still the same
    loop:
        li $v0, 4
        la $a0, newline
        syscall
        li $v0, 4
        la $a0, mainResult
        syscall
        li $v0, 1
        move $a0, $s0
        syscall
        
        jal printFromFunction# jumo to the function that prints a seperate value to be stored in $s0 (address of this line in $ra now)
        j loop# jump to the start of the loop
    
    # this function demonstrates how to save values from reg. to stack, and restore post function call
    printFromFunction: 
        # print the prompt specific to this function and take in a new value for $s0
        li $v0, 4
        la $a0, newline
        syscall
        li $v0, 4
        la $a0, promptFunction
        syscall
        li $v0, 5
        syscall
        
        beq $v0 $zero exit # if the user input is 0 we want to quit, so jump to the exit label
        
        # creates 4 bytes of space on the stack and saves the value of $s0 we want to hold onto for main on the stack
        addi $sp, $sp, -4
        sw $s0, 0($sp)
        move $s0 $v0 # moves the user input we recieved at the start of the function from $v0 into and $s0 overwriting the old value of $s0
        
        # prints our new value of $s0
        li $v0, 4
        la $a0, functionResult
        syscall
        li $v0 , 1
        move $a0, $s0
        syscall
        li $v0, 4
        la $a0, newline
        syscall
        
        #restores the value of $s0 to the one that we saved on the stack, then moves the stack pointer back 4 bytes since we no longer need it
        lw $s0, 0($sp) # to get better insight try commenting out these 2 lines and run the program. 
        addi $sp, $sp, 4
        
        jr $ra # returns back to the caller
    
    # this closes the program and can only run if 0 is entered inside the function
    exit: 
        li $v0, 10
        syscall