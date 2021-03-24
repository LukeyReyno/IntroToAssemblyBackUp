# Suppose you have access to two subroutines, abs, and divide 
# (their function headers are given below. Using these functions, 
# write a main function to calculate the following value where 
# x is located in memory at address 0x6000 and y is located in memory at address 0x6004. 
# Save the resulting quotient in address location 0x6020 and the remainder in location 0x6024. 
# Do not worry about saving any registers on the stack. 

# |???| / |?|
##########################
# Function: abs
# Calculates the absolute value of the input # Arguments: a0 - A
# Return value: a0 - |A|
# Changed registers: a0
###########################
##########################
# Function: divide
# Calculates A/B # Arguments: a0 – A, a1 - B
# Return values: a0 – Quotient, a1 - Remainder
# Changed registers: a0, a1, s0
###########################


.eqv 	IN_ADDR, 0x6000
.eqv	OUT_ADDR, 0x6020

	li	sp, 0x10000
	li	t0, IN_ADDR
	li	t1, OUT_ADDR
	lw	t2, 0(t0)	#get x
	lw	t3, 4(t0)	#get y
	mv	a0, t2
	# save all t registers
	call 	abs
	# restore all t registers
	mv	t4, a0		#t4 has abs(x)
	sub	t5, t2, t3	#t5 has x - y
	mv	a0, t5		
	call	abs		#t5 has |x-y|
	mv	a1, t4
	call 	divide
	sw	a0, 0(t1)
	sw	a1, 4(t1)
	
end:	j	end