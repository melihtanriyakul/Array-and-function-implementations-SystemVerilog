.data		# variable declarations follow this line
var1:	.word 3 	# int a;
var2: 	.word 5		# int b;
result: .word 0		# int result;

.text

main:
	addi $sp, $sp, -12		# stack frame
	sw $ra, 0($sp)			# store $ra
	lw $a0, var1			# a = 3
	lw $a1, var2			# b = 3
	lw $a2, result			# result = 0
	sw $a2, 4($sp)			# store result
	bne $a0,$a1, else		# no:
	add $a2, $a1, $a0 		# $a2 = a + b
	sw $a2, result			# result = a + b
	addi $sp, $sp, 12		# restore $sp
	jr $ra					# return
	
else:
	jal test				# call test, the function
	lw $ra, 0($sp)			# restore $ra
	addi $sp, $sp, 4		# restore $sp	
	jr $ra					# return
	
test:
	sw $ra, 8($sp)			# store $ra
	slt $t1, $a0, $a1		# a < b ?
	beq $t1, $0, else1		# if not then else1
	jal multiply			# call multiply
	lw $a2, 4($sp)			# $a2 = a * b
	sw $a2, result			# result = a * b
	lw $ra, 0($sp)			# restore $ra
	addi $sp, $sp, 12		# restore $sp
	jr $ra					# return
	
else1:
	jal subtract			# call subtract
	lw $a2, 4($sp)			# $a2 = a - b
	sw $a2, result			# result = a - b
	lw $ra, 0($sp)			# restore $ra
	addi $sp, $sp, 12		# restore $sp
	jr $ra					# return
	
subtract:
	sub $a2, $a0, $a1		# $a2 = a - b
	sw $a2, 4($sp)			# store $a2 in stack
	jr $ra					# return
	
multiply:
	mul $a2, $a0, $a1		# $a2 = a * b
	sw $a2, 4($sp)			# store $a2 in stack
	jr $ra					# return