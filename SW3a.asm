.eqv	SWITCHES, 	0x11000000
.eqv	SEVEN_SEGMENT,	0x11000040

	li	x1, SWITCHES
	li	x7, SEVEN_SEGMENT
	li	x3, 32768
	
	#li	x6, 32000 #could also input values manually during execution
	#sw	x6, 0(x1) 
	lw	x2, 0(x1)
	
	bge	x2, x3, divide
	slli	x2, x2, 1		#multiply by 2
	j	end
	
divide:	srai	x2, x2, 2		#divide by 4
		
end:	sw	x2, 0(x7)
