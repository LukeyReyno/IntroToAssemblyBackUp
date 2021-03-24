.data
.word	0xff, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x90, 0xaa, 0xbb, 0xff

.eqv	IN_ADDRESS,  0x6000
.eqv	OUT_ADDRESS, 0x6060
.eqv	COUNTER,     4


.text
Main:		li	a0, IN_ADDRESS
		li	a1, OUT_ADDRESS
		li	a2, COUNTER
		#call	bytePacking
		call	maxMinFind
end:		j	end

#####################
# Function: Byte Packing
# Arguments: a0 - n (memory address), a1 - m (memory address), a2 - counter
# Return value: void
# Changed Registers: s4, s5, s6, s7, s8, s9, s10
#####################

bytePacking: 	addi	s4, a2, 0 	# decrementing counter
		addi	s5, a0, 0 	# in_address offset
		addi	s10, a1, 0	# out_address 
		li	s8, 32		# used as modulo for shift
		li	s9, 0		# left shift value per word
		
packLoop:	beqz	s4, endPack
		lbu	s6, (s5)
		bge	s9, s8, shiftWord
packContinue:	rem	s9, s9, s8
		sll	s6, s6, s9
		lw	s7, (s10)
		add	s6, s6, s7
		sw	s6, (s10)
		
		addi	s4, s4, -1
		addi	s5, s5, 4
		addi	s9, s9, 8
		
		j	packLoop

shiftWord:	addi	s10, s10, 4
		j	packContinue

endPack:	ret	

#####################
# Function: MaxMinFind
# Arguments: a0 - n (memory address), a1 - m (memory address), a2 - counter
# Return value: void
# Changed Registers: s4, s5, s6, s7, s8
#####################

maxMinFind: 	addi	s4, a2, -1 	# decrementing counter
		addi	s5, a0, 0 	# in_address offset
		lw	s7, (s5)	# tempMaxValue
		lw	s8, (s5)	# tempMinValue
		addi	s5, s5, 4
		
mmLoop:		beqz	s4, endMMFind
		lw	s6, (s5)
		bgtu	s6, s7, newMax
		bltu	s6, s8, newMin
		
mmContinue:	addi	s4, s4, -1
		addi	s5, s5, 4
		
		j	mmLoop

newMax:		addi	s7, s6, 0
		j	mmContinue
		
newMin:		addi	s8, s6, 0
		j	mmContinue

endMMFind:	sw	s8, (a1)
		sw	s7, 4(a1)
		ret	
