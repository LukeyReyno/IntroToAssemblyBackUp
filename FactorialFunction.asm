

Main:			li	sp, 0x10000	#initialize stack pointer
			li	a0, 3	#n=5
			call 	Factorial
			
end:			j	end


#####################
# Function: Factorial
# Arguments: a0 - n
# Return value: a0 = n!
# Changed Registers: s2, a2, a1, ra
#####################

Factorial:		addi	sp, sp, -8	#save values on stack
			sw	ra, 0(sp)
			sw	s2, 4(sp)
			li	s2, 1	#put 1 in a register for comparison
			bge	s2, a0, done	#if n <= 1 then I'm done
			mv	a2, a0		#a2 has n
			addi	a1, a0, -1	#a1 has n-1
loop1:			call	Multiply
			mv	a2, a0	#move result into next argument
			addi	a1, a1, -1 # a1 has next thing to multiply
			bge	a1, s3, loop1
done:			lw	ra, 0(sp)	#restore values from stack
			lw	s2, 4(sp)	
			addi	sp, sp, 8
			ret


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


