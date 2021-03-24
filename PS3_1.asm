.eqv	num, 0xFFFF

	li	x4, num
	lw	x1, (x4)
	
	andi	x3, x1, 0xFF
	blez	x3, end
	andi	x3, x3, 32

end:	sw	x3, (x4)
