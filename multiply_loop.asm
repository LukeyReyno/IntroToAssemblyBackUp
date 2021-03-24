# Write an assembly program thta multiples x11 and x12 and saves the result in x10

start:	li	x10, 0 		#initialize result
	beqz	x11, start	#beqz == beq with x0
loop:	beqz	x12, start
	add 	x10, x10, x11
	addi	x12, x12, -1
	j	loop