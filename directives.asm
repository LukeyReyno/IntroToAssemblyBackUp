.data
.word 0xABCDEF22
.half 0xABCD, 0x1234
.byte 0xAB, 0xCD, 0xEF, 0x12
.space 8
.word 0xAB

.text
	li 	x1, 0x6000	#put address of data segment in register
	lw	x2, 0(x1)
	lh	x3, 0(x1)
	lb	x4, 0(x1)
	lb	x5, 3(x1)
	lbu	x6, 3(x1)