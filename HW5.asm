	lui 	x5, 0x11000
	lui	x6, 0x11080
main:	lw	x7, 0(x5)
	xori	x8, x7, -1
	sw	x8, 0(x6)
	j	main