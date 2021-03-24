
########################
# Interrupt example
# Shows number of interrupts that occured on sseg display
########################

.eqv SSEG_CONTROL_AD, 0x11000024
.eqv SSEG_CNT1_AD, 0x11000028

.eqv 	TC_CONTROL_AD, 0x11000030
.eqv	TC_CNT_IN_AD, 0x11000034

init:	li	s1, SSEG_CONTROL_AD
	li	s2, SSEG_CNT1_AD
	li	s11, TC_CNT_IN_AD	# interrupt length address
	li	a5, TC_CONTROL_AD	# control addresss
	
	li     	s7, 6249999  # for ~1Hz blink rate          
	sw     	s7, 0(s11)      # init TC count
	
	li     	s7, 0x71        # init TC CSR          
	sw     	s7, 0(a5)
	
	li	s3, 1		# value in control register
	sw	s3, 0(s1)	# write to sseg control register
	li	s3, 0		# value to show to sseg
	sw	s3, 0(s2)	# writes a zero to sseg
	la	s4, ISR		# put address of ISR into s4
	csrrw	x0, mtvec, s4	# save address of ISR into mtvec
	li	s4, 1		# put 1 in register to allow for enabling interrupt
	csrrw	x0, mie, s4	# enable interrupt
	li	s8, 10
loop:	nop			# no operation	
	j 	loop		#wait in endless loop for interrupts
	
end:	sw	x0, (s1)
	j	end
	

#######################
# ISR: Counts the number of interrupts
# uses global register s3
#######################
ISR:	addi	s3, s3, 1	# increment count
	sw	s3, 0(s2)	# output to sseg
	csrrw	x0, mie, s4	# return with interrupts enabled
	bne	s8, s3, endI
	csrrw	x0, mie, x0
	li	s8, 0x64
	csrrw	x0, mepc, s8
endI:	mret
