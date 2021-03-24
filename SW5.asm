
Main:			li	a0, 0xa	#n=09029
			call 	bin2BCD		
endMain:		j	endMain


#####################
# Function: unsigned bin to BCD
# Arguments: a0 - n
# Return value: a0 = BCD(n)
# Changed Registers: s4, s5, s6, s7, s8
#####################
bin2BCD:		addi	t0, ra, 0
			addi	a1, a0, 0
			li	a2, 10000
			call	Divide
			mv	s4, a3
			
			li	a2, 1000
			call 	Divide
			mv	s5, a3
			
			li	a2, 100
			call 	Divide
			mv	s6, a3
			
			li	a2, 0xa
			call	Divide
			mv	s7, a3
			
			li	a2, 1
			call	Divide
			mv	s8, a3
			addi	ra, t0, 0
			
			add	a0, s4, a0
			slli	a0, a0, 4
			add	a0, s5, a0
			slli	a0, a0, 4
			add	a0, s6, a0
			slli	a0, a0, 4
			add	a0, s7, a0
			slli	a0, a0, 4
			add	a0, s8, a0
			slli	a0, a0, 4
			ret




#####################
# Function: Divide
# Arguments: a1 - A, a2 - B
# Return Value: a3 = A // B, a1 = A % B
# Changed Registers: a3, a1
#####################

Divide:	li 	a3, 0
	beqz	a2, divZero
	
loop:	blt	a1, a2, end
	sub	a1, a1, a2
	addi	a3, a3, 1
	j	loop
	
divZero:
	li	a3, -1
	j	end
	
end:	ret
