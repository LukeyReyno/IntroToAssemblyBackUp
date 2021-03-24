	li	sp, 0xFFFF	# initialize stack pointer
	li	s0, 4		# put a value in a register
	
	addi	sp, sp, -4	# decrement sp
	sw	s0, 0(sp)	# push value on stack
	
	addi	sp, sp, -4
	sw	s0, 0(sp)
	
	lw	s1, 0(sp)	# pop value off stack
	addi	sp, sp, 4 	#increment sp