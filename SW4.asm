.data	#0x6000						   #0x603c
#.word	2, 7, 14, 4, 16, 11, 6, 15, 13, 8, 1, 6, 5, 0, 12, 9
.word	654, 21, 544, 897, 12, 1, -555, 77, 9, 5545, 7982, 123, 8795, 9, 1252, 16

.eqv	ARRAY_SIZE, 16 # n elements

.text
	li	x3, ARRAY_SIZE	# array size
	add	x4, x3, x0
	slli	x2, x3, 2	# multiply array size by 4 to calculate address of last element
	add	x2, x1, x2
	addi	x2, x2, -4	# back up one spot to point to last element

newR:	li	x7, 0
	li	x1, 0x6000 	# first array address
	addi	x4, x4, -1 	# set counter as n - 1
	beqz	x4, end
	
bubble:	lw	x5, 0(x1)
	lw	x6, 4(x1)
	bgt	x5, x6, swap

check:	addi	x1, x1, 4	# move to next element
	addi	x7, x7, 1
	beq	x7, x4, newR
	j	bubble
	
swap:	sw	x5, 4(x1)	# put bigger in smaller spot
	sw	x6, 0(x1)	# put smaller in bigger spot
	j	check
	
end:
