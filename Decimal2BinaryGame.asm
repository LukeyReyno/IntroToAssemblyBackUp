######################################
# Final Project


######BE SURE THESE ADDRESSES MATCH THE ONES
########YOU HAVE IN YOUR OTTER WRAPPER
.eqv	LEDS, 0x11000020
.eqv	BUTTONS, 0x11000004
.eqv	SWITCHES, 0x11000000
.eqv	PRNG_OUT_AD, 0x11000040

.eqv	DELAY_AMT, 3125000
.eqv	RNG_BUFFER, 1200

.eqv	SSEG_CNT1_AD, 0x11000028
.eqv	SSEG_CNT2_AD, 0x1100002C
.eqv	SSEG_CONTROL_AD, 0x11000024

.text
init:   la    	x6, ISR          # load address of ISR into x6          
	csrrw  	x0, mtvec,x6     # store address as interrupt vector CSR[mtvec]          
	csrw   	x6, mtvec 
	
	li	s0, BUTTONS
	li	s1, LEDS
	li	s9, SWITCHES
	li	s5, SSEG_CNT1_AD
	li	s6, SSEG_CONTROL_AD
	li	s8, PRNG_OUT_AD   

Main:	li	s7, 0x80	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	li	s7, 0		#initial sseg value
	sw	s7, 0(s5)       #put initial value to sseg
	
	li	s3, 1		#initial LED value
	li	s2, 5		#inital rounds left
	
round:	beqz	s2, blink
	li	s7, 0x81	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	sw	s3, 0(s1)
	lbu	s10, 0(s8)	# random number player needs to guess
	sw	s10, 0(s5)	#puts random number on sseg
	li     	s7, 1
	csrrw	x0, mie, s7	#enable interrupts
roundL:	nop			#wait for interrupt
	j	roundL
	
blink:	csrrw	x0, mie, x0	#disable interrupts
	li	s7, 0x80	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	li	s3, 9		#blink counter
blinkL:	li	s7, 0xFFFF	# ON LEDS
	sw	s7, 0(s1)	#put value to LED
	li	a0, DELAY_AMT
	call	Delay
	li	s7, 0x0		# OFF LEDS
	sw	s7, 0(s1)	#put value to LED
	li	a0, DELAY_AMT
	call	Delay
	addi	s3, s3, -1
	bnez	s3, blinkL
	j	Main

ISR:	lhu 	s7, 0(s9)
	bne	s7, s10, wrong	#incorrect switches value
	slli	s3, s3, 1	#multiply LED value for unary count
	addi	s3, s3, 1	#increment LED value
	addi	s2, s2, -1	#decrement win value
wrong:	csrrw	x0, mie, x0	#enable interrupts
	la	s7, round
	csrrw	x0, mepc, s7
	mret


##################################
#Function: Delay
#Argument a0: Amount of delay (4*a0*T)
#Return Value: nothing
#Changed Registers: a0
##################################
Delay:	addi	a0, a0, -1	
	bnez	a0, Delay
	ret