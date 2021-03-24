.eqv 	SWITCH,		0x11000000
.eqv	LEDS, 		0x11000020

		li 	x1, SWITCH
		li 	x2, LEDS
		li	x6, 0x0501
		sw	x6, (x1)
		lw	x7, (x1)
		li	x6, 0x0042
		sw	x6, (x1)
		lw	x8, (x1)
		li	x6, 0x0003
		sw	x6, (x1)
		lw	x9, (x1)
		
		bgt	x7, x8, comp1
		j	comp2
		
comp1:		bgt	x7, x9, reg7
		j	reg9
		
comp2:		bgt	x8, x9, reg8
		j	reg9


reg7:		sw	x7, (x2)
		j	end
		
reg8:		sw	x8, (x2)
		j	end
		
reg9:		sw	x9, (x2)
		j	end

end:		
