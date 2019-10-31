# MIPS Assignment 1
.data
	str: .space 32
	message: .asciiz "Input: "
	message1: .asciiz "\nOutput: "
	sum: .word 0

.text # for instructions
main:
	
	# prints message
	li $v0, 4
	la $a0, message
	syscall
	
	# read a string to operate on
	li $v0, 8
	la $a0, str
	li $a1, 11 # space for 11 characters
	syscall
	
	move $t7, $a0 # moves string into $t7 register
	
	# prints character at index 0
	li $t1, 10 # initialize register $t1 to 10
	li $t2, 0 # initialize byte number to 0
	
	lw $t9, sum # loads sum into register
	
	li $k0, 0 # puts zero in total sum
	for_loop:
	blt $t1, 1, exit # Branch less than 10 < 1
	
    lbu $a0, 0($t7) # Loads byte 0 of $t7 (str)
    #li $v0, 11 # prints character
    #syscall
    
    # Algorithm for checking characters
    # check space
    li $t0, 48 # ASCII 0
    blt $a0, $t0, outside # character index of string <= 48 if true run outside
    j check0
    
    return: # resumes after checking
    
    # iteration
    addi $t7, 1 # next char
	add $t2, $t2, 1 # Adds 1 to $t2 to get the next character
	sub $t1, $t1, 1 # --10
	
	j for_loop
	
	# Exit call
	li $v0, 0
	syscall
	
	check0:
    li $t0, 0
    bge $a0, $t0, check9 # character index of string > 0 if true run check9
    
    j return
	
	check9:
	li $t0, 57 #ASCII A
	bge $a0, $t0, between9andA # character index of string >= 57f if true run checkA
	
	# False
	# Conversion and summation
	sub $t9, $a0, 48 # 48 - 48 is 0 in decimal
	add $k0, $k0, $t9 # adds character to total sum $k0
	
	j return
	
	between9andA:
	li $t0, 65 #ASCII A
	bge $a0, $t0, checkA # character index of string >= 65 if true run checkA
	
	j return
	
	checkA:
	li $t0, 84 #ASCII after S
	bge $a0, $t0, betweenSanda # character index of string >= 84 if true run betweenSanda
	
	# False
	# Conversion and summation
	sub $t9, $a0, 55 # A - 55 is 10 in decimal
	add $k0, $k0, $t9 # adds character to total sum
	
	j return
	
	betweenSanda:
	li $t0, 97 #ASCII a
	bge $a0, $t0, checkS # character index of string >= 97 if true run checkA
	
	j return
	
	checkS:
	li $t0, 115 # ASCII S
	bge $a0, $t0, checkaa # character index of string >= 115 if true run checkA
	
	# False
	# Conversion and summation
	sub $t9, $a0, 87 # A - 87 is 10 in decimal
	add $k0, $k0, $t9 # adds character to total sum

	j return

	
	checkaa: # check a character
	li $t0, 97 # ASCII a
	bge $a0, $t0, checkss # character index of string >= 97 if true run checkss
	
	# False
	# Conversion and summation
	sub $t9, $a0, 87 # a - 87 is 10 in decimal
	add $k0, $k0, $t9 # adds character to total sum

	j return
	
	checkss: # check s character
	li $t0, 116 # ASCII after s
	bge $a0, $t0, outside # character index of string >= 116 if true run outside
	
	# False
	# Conversion and summation
	sub $t9, $a0, 87 # a - 87 is 10 in decimal
	add $k0, $k0, $t9 # adds character to total sum
	
	j return

	outside: # outside
	
	j return
	
	exit:
	
	# prints message1
	li $v0, 4
	la $a0, message1
	syscall
	
	# print int
	li $v0, 1
	add $a0, $zero, $k0 # put 0 + $k0 in argument register
	syscall
	
	li $v0, 0
	syscall