# Reverse an Array

.data   #0x6000		#0x6014
.word	2, 8, 6, 7, 3, 1

.eqv	ARRAY_SIZE, 6

.text

	li	x1, 0x6000	#first array address
	li	x3, ARRAY_SIZE	#array size
	slli	x2, x3, 2	#multiply array size by 4 to calculate address of last element
	add	x2, x1, x2
	addi	x2, x2, -4	#back up one spot to point to last element
	srai	x4, x3, 1	#set counter to array_size/2
	
	#perform swap
swap:	lw	x5, 0(x1)	#get first element
	lw	x6, 0(x2)	#get last element
	sw	x5, 0(x2)	#put first in last spot
	sw	x6, 0(x1)	#put last in first spot
	
	addi	x4, x4, -1	#decrement counter
	beqz	x4, end		#end if done swapping
	addi	x1, x1, 4	#move first address up to next element
	addi	x2, x2, -4	#move last address down to last element
	j	swap
	
end:	