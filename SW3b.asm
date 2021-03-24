.eqv	SWITCHES, 	0x11000000
.eqv	LEDS,		0x11000020
.eqv	SEVEN_SEGMENT,	0x11000040

	li	x1, SWITCHES
	li	x2, LEDS
	li	x7, SEVEN_SEGMENT
	
	li	x6, 500 #could also input values manually during execution
	sh	x6, 0(x1) 
	lh	x3, 0(x1)
	li	x6, 222
	sh	x6, 0(x1)
	lh	x4, 0(x1)
	
	li	x5, 0
	
	beqz	x4, divZero
	
	#div	x5, x3, x4
loop:	blt	x3, x4, endloop
	sub	x3, x3, x4
	addi	x5, x5, 1
	j	loop
	
	
endloop:sw	x5, (x7)
	sw	x3, (x2)
	j	end
	
	
divZero:
	li	x6, 0xFFFFFFFF
	sw	x6, (x2)
	sw	x6, (x7)
	j	end
	
end:
