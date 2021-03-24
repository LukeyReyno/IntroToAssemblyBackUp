######################################
# Example code to show interface with
# buttons, leds, and universal sseg
#######################################


######BE SURE THESE ADDRESSES MATCH THE ONES
########YOU HAVE IN YOUR OTTER WRAPPER
.eqv	LEDS, 0x11000020
.eqv	BUTTONS, 0x11000004
.eqv	DELAY_AMT, 3125000
.eqv	SSEG_CNT1_AD, 0x11000028
.eqv	SSEG_CNT2_AD, 0x1100002C
.eqv	SSEG_CONTROL_AD 0x11000024

.text
	li	s0, BUTTONS
	li	s1, LEDS
	li	s5, SSEG_CNT1_AD
	li	s6, SSEG_CONTROL_AD
	li	s7, 1	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	li	s8, 0	#initial sseg value
	sw	s8, 0(s5)  #put initial value to sseg
Main:	lw	s2, 0(s0)	#read Buttons
	li	s3, 0x1		#mask for BTNR
	and	s3, s2, s3	#s3 tells us if BTNR was pressed
	bnez	s3, BTNR
	li	s3, 0x2		#mask for BTNU
	and	s3, s3, s2	#s3 tells us if BTNU was pressed
	bnez	s3, BTNU
	li	s3, 0x4		#mask for BTNL
	and	s3, s3, s2
	bnez	s3, BTNL
	li	s3, 0x8
	and	s3, s3, s2
	bnez	s3, BTND
	j	Main
	
	
BTNR:	addi	s8, s8, 1	#increment sseg count
	sw	s8, 0(s5)	#display to sseg
	li	s3, 0x8000	#16th LED is on
loopR:	sw	s3, 0(s1)	#put value into LED
	li	a0, DELAY_AMT
	call	Delay
	srli	s3, s3, 1	#shift LED to the right
	bnez	s3, loopR
	j	Main

BTNU:	j	Main

BTNL:	addi	s8, s8, 1	#increment sseg count
	sw	s8, 0(s5)	#display to sseg
	li	s3, 0x1
	li	s4, 0x10000
loopL:	sw	s3, 0(s1)	#put value to LED
	li	a0, DELAY_AMT
	call	Delay
	slli	s3, s3, 1
	bne	s3, s4, loopL
	j	Main

BTND: 	j	Main


##################################
#Function: Delay
#Argument a0: Amount of delay (4*a0*T)
#Return Value: nothing
#Changed Registers: a0
##################################
Delay:	addi	a0, a0, -1	
	bnez	a0, Delay
	ret
