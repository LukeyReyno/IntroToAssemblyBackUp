Main:			li	a0, 0x10	#n=9342
			call 	BCD2bin
			
endMain:		j	endMain


#####################
# Function: BCD to bin
# Arguments: a0 - n
# Return value: s4 = bin(n)
# Changed Registers: s4, s5, a1
#####################
BCD2bin:		addi	t3, ra, 0
			andi	s5, a0, 0x000f
			add	s4, s4, s5
			
			srli	a0, a0, 4
			andi	s5, a0, 0x000f
			addi	a1, s5, 0
			li	a2, 10
			call	Multiply
			add	s4, s4, a3

			srli	a0, a0, 4
			andi	s5, a0, 0x000f
			addi	a1, s5, 0
			li	a2, 100
			call	Multiply
			add	s4, s4, a3
			
			srli	a0, a0, 4
			andi	s5, a0, 0x000f
			addi	a1, s5, 0
			li	a2, 1000
			call	Multiply
			add	s4, s4, a3
			
			addi	ra, t3, 0
			ret



#####################
# Function: Multiply
# Arguments: a1 - A, a2 - B
# Return Value: a3 = A*B
# Changed Registers: a3, a2
#####################

Multiply:		li	a3, 0 	#initialize result to zero
			beqz	a1, endmult
multloop:		beqz	a2, endmult	#loop to calculate product
			add	a3, a3, a1
			addi	a2, a2, -1
			j	multloop
endmult:		ret
