# Write the code to calculate the 8th and 17th position of the Fibonacci code 
# and save these values to address location 0x6000 and 0x6004 respectively. 
# Assume you have access to the Fib function (its function header is given below). 
# Do not worry about saving any registers on the stack.

.eqv 	ADDR, 0x6000

Main: 	li 	sp, sp, 0x10000
	li 	t0, ADDR
	li 	a0, 8
	call 	Fib
	sw 	a0, 0(t0)
	li 	a0, 17
	call 	Fib
	sw 	a0, 4(t0)
end: 	j 	end


sub 
##########################
# Function: Fib
# Calculates The Nth Number in Fibonacci sequence
# Arguments: a0 – N
# Return values: a0 – Nth number in Fibonacci sequence
# Changed registers: a0, s0, s1, s2, s3
###########################