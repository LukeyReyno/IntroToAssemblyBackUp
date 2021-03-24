#####################
# Function: Multiply
# Arguments: a1 - A, a2 - B
# Return Value: a0 = A*B
# Changed Registers: a0, a2
#####################

Multiply:		li	a0, 0 	#initialize result to zero
			beqz	a1, endmult
multloop:		beqz	a2, endmult	#loop to calculate product
			add	a0, a0, a1
			addi	a2, a2, -1
			j	multloop
endmult:		ret