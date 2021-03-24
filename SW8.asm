######################################
# SW 8: Interrupts with Timer Counter


######BE SURE THESE ADDRESSES MATCH THE ONES
########YOU HAVE IN YOUR OTTER WRAPPER
.eqv	LEDS, 0x11000020
.eqv	BUTTONS, 0x11000004
.eqv	SWITCHES, 0x11000000
.eqv 	TC_CNT_OUT_AD, 0x11000008
.eqv	DELAY_AMT, 3125000

.eqv	SSEG_CNT1_AD, 0x11000028
.eqv	SSEG_CNT2_AD, 0x1100002C
.eqv	SSEG_CONTROL_AD, 0x11000024

.eqv 	TC_CONTROL_AD, 0x11000030
.eqv	TC_CNT_IN_AD, 0x11000034

.text
init:   la    	x6, ISR          # load address of ISR into x6          
	csrrw  	x0, mtvec,x6     # store address as interrupt vector CSR[mtvec]          
	csrw   	x6, mtvec 
	
	li	s0, BUTTONS
	li	s1, LEDS
	li	s9, SWITCHES
	li	s5, SSEG_CNT1_AD
	li	s6, SSEG_CONTROL_AD
	li	s11, TC_CNT_IN_AD	# interrupt length address
	li	a5, TC_CONTROL_AD	# control addresss
	li	a6, TC_CNT_OUT_AD	# interrupt value address
	
	li     	s7, 6249999     # for ~1Hz blink rate          
	sw     	s7, 0(s11)      # init TC count
	
	li     	s7, 0x71        # init TC CSR          
	sw     	s7, 0(a5)      

Reset:	li	s7, 0x80	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	li	s8, 0		#initial sseg value
	sw	s8, 0(s5)       #put initial value to sseg

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
	
BTNR:	j	Main

BTNU:	li	s7, 0x81	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	lw	s10, 0(s9)	#load switches value
	addi	a0, s10, 0
	call	BCD2bin
	sw	s4, 0(s5)	#put value to sseg
	li     	s7, 1
	csrrw	x0, mie, s7	#enable interrupts     
loop:	beqz	s4, blink
	j 	loop		# waiting for interrupts
	
blink:	csrrw	x0, mie, x0	#disable interrupts
	li	s7, 0x80	#sseg control value
	sw	s7, 0(s6)	#load control to sseg
	li	s3, 9		#blink counter
blinkL:	li	s2, 0xFFFF	# ON LEDS
	sw	s2, 0(s1)	#put value to LED
	li	a0, DELAY_AMT
	call	Delay
	li	s2, 0x0		# OFF LEDS
	sw	s2, 0(s1)	#put value to LED
	li	a0, DELAY_AMT
	call	Delay
	addi	s3, s3, -1
	bnez	s3, blinkL
	j	Main

BTNL:	j	Main

BTND: 	j	Main

ISR:	addi	s4, s4, -1
	sw	s4, 0(s5)	#put value to sseg
	li     	s7, 1
	csrrw	x0, mie, s7	#enable interrupts   
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


#####################
# Function: BCD to bin
# Arguments: a0 - n
# Return value: s4 = bin(n)
# Changed Registers: s3, s4, a1
#####################
BCD2bin:		addi	t3, ra, 0
			andi	s3, a0, 0x000f
			li	s4, 0
			add	s4, s4, s3
			
			srli	a0, a0, 4
			andi	s3, a0, 0x000f
			addi	a1, s3, 0
			li	a2, 10
			call	Multiply
			add	s4, s4, a3

			srli	a0, a0, 4
			andi	s3, a0, 0x000f
			addi	a1, s3, 0
			li	a2, 100
			call	Multiply
			add	s4, s4, a3
			
			srli	a0, a0, 4
			andi	s3, a0, 0x000f
			addi	a1, s3, 0
			li	a2, 1000
			call	Multiply
			add	s4, s4, a3
			
			addi	ra, t3, 0
			ret



#####################
# Function: Multiply
# Arguments: a1 - A, a2 - B
# Return Value: a3 = A*B
# Changed Registers: a3, a2
#####################

Multiply:		li	a3, 0 	#initialize result to zero
			beqz	a1, endmult
multloop:		beqz	a2, endmult	#loop to calculate product
			add	a3, a3, a1
			addi	a2, a2, -1
			j	multloop
endmult:		ret
