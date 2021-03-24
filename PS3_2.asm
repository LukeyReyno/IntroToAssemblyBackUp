# Write an assembly language program that calculates the average of class grades (there are 32 of them) that are stored in memory starting at address 0x6000.  
# Put the average grade in register x10.  

.data 
.word 	85, 80, 90, 100, 80, 90, 85, 100

.eqv	COUNTER, 8	# power of 2
.eqv	SHIFT, 3	# log2(Counter)

.text

	li	x1, 0x6000
	li	x2, COUNTER
	li	x10, 0
	
loop:	lw	x4, (x1)
	add	x10, x10, x4
	addi	x2, x2, -1
	beqz	x2, end
	addi	x1, x1, 4
	j	loop
	
end:	srai	x10, x10, SHIFT