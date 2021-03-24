##########################
# SW 1
# By: Lucas Reyna
# Date: 1/9/21
##########################

	li 	x1, 1 #load immediate (li) 
	li	x2, 2
	li	x3, 3

Func: 	add	x4, x1, x1 #Second part of SW1
	add	x4, x4, x2
	sub	x4, x4, x3
	addi	x4, x4, 10

Main:   addi 	x6, x0, 0 #First part of SW1
	lw 	x5, 0(x6)
	xori	x5, x5, -1
	sw	x5, 0(x6)
	jal	x0, Main #0x1FFFF0
