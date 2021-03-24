.data
.word 0xABCD1234, 0xABCDEF22
#.word 0x00000199, 0x0000005A
#.word 1, 2
.text
	li 	x1, 0x6000
	li	x2, 0x6004
	li	x20, 0x6020
	li	x11, 1
	li	x12, 2
	lw	x3, 0(x1)
	lw	x4, 0(x2)
	
	add	x5, x3, x4
	li	x30, 500
	bgt	x5, x30, ifgreater
	sb	x11, 0(x20)
	j	skip
	
ifgreater:
	sb	x12, (x20)
	
skip:

