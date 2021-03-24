# Write a RISC-V assembly language program that continuously does the following: 
#	inputs ten words of unsigned data from port address 0x11000000, 
#	sums those inputs, divides the result by 4, 
#	then outputs the result to port address 0x11000020, 
#	then repeats. Don’t worry about overflow for this problem.

.eqv	INPUT, 	0x11000000
.eqv	OUTPUT, 0x11000020
.eqv	COUNT, 10

	li	x1, INPUT
	li	x2, OUTPUT

Main:	li	x3, COUNT
	li	x4, 0

loop:	lw	x5, (x1)
	add	x4, x4, x5
	addi	x3, x3, -1
	beqz	x3, endLoop
	j	loop
	
endLoop:
	srai	x4, x4, 2
	sw	x4, (x2)
	j	Main