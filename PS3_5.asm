# Write a RISC-V assembly language program that continuously does the following: 
#	inputs 64 unsigned halfwords from port address 0x11000020 and outputs the average of the value to port address 0x11000040. 

.eqv	INPUT, 	0x11000020
.eqv	OUTPUT,	0x11000040
.eqv	COUNT,	64
.eqv	SHIFT,	6

	li	x1, INPUT
	li	x2, OUTPUT
	
Main:	li	x3, COUNT
	li	x4, 0
	
loop:	lhu	x5, (x1)
	add	x4, x4, x5
	addi	x3, x3, -1
	beqz	x3, endLoop
	j	loop
	
endLoop: 
	srai	x4, x4, SHIFT
	sw	x4, (x2)
	j	Main
	