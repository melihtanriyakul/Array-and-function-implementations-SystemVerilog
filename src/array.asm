.data	# array declarations follow this line 						
A: .word 2, 0, -2, 0, 3, -3, 0, 0, 4, -4	# array declaration 
	
.text 	# instructions follow this line										

main:	la $t1, A				# address of the first element of array A
		addi $t0, $0, 10		# $t0 = 10
		addi $s0, $0, 0			# $s0 = i
		
for:	beq $s0, $t0, done 		# i = 10 ?
		sll $t2, $s0, 2 		# $t2 = i * 4 (offset)
		add $t2, $t2, $t1 		# address of A[i]
		lw $t3, 0($t2) 			# $t3 = A[i]
		slt $t4, $t3, $0		# A[i] < 0
		beq $t4, $0, else		# if not then go to else
		sll $t5, $t3, 2			# since we are asked to multiply by -5 when the number is negative, we shift left the number by 2 
		add $t5, $t5, $t3		# and add the numbers itself to get negative value of the result
		nor $t5, $t5, $0		# after we get the negative of the result we inverted 
		addi $t5, $t5, 1		# and +1 to take two's complement to get the result
		sw $t5, 0($t2) 			# now A[i] = -5 * A[i]
		addi $s0, $s0, 1		# i = i + 1
		j for					# return to for loop
	
else:	sll $t5, $t3, 2			# shifting 2 bits for
		add $t5, $t5,$t3		# adding itself for multiplying by 5.
		sw $t5, 0($t2)
		addi $s0, $s0, 1		# i = i + 1
		j for
done:
	jr $ra						# return to OS
		