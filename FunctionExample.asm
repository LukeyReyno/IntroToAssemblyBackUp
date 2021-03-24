#############################
# Function Example
# In python:
# def my_function(g, h, i, j):
#	result = (g+h) - (i+j)
#	return result
#
# Write the fucntion and call it from main
# By: Bridget Benson
# 2/3/21
#############################
		li	sp, 0xF000

Main:		li	a0, 5
		li	a1, 6
		li	a2, 7
		li	a3, 8
		addi	sp, sp -4	#save any registers caller has to save on stack
		sw	a0, 0(sp)
		call	my_function
		mv	t0, a0		#move result of function to t0
		lw	a0, 0(sp)	#restore argument a0
		addi	sp, sp, 4
end:		j	end




#############################
# Function: my_function
# Description: (g+h) - (i+j)
# Arguments: a0 - g, a1 - h, a2 - i, a3 - j
# Return values: a0
# Changed registers: a0, s0, s1
############################
my_function:	addi	sp, sp, -8	#allocate to push 2 values on stack
		sw	s0, 0(sp)	#push s registers that are changed on stack
		sw	s1, 4(sp)	#callee saves value
		add	s0, a0, a1	#s0 = g+h
		add	s1, a2, a3	#s1 = i+j
		sub 	a0, s0, s1	#a0 = (g+h) - (i+j)
		lw	s1, 4(sp)	#restore the saved registers from the stack
		lw	s0, 0(sp)
		addi	sp, sp, 8
		ret	
