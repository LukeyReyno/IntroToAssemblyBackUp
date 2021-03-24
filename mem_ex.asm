####################################
# Program to demonstrate lw/sw and directives
# Lucas Reyna
# 1/13/2021
####################################


.data 	#anything taht starts with a dot is a directive
	#.data refers to data segment of memory

.word 	# word refers to 32 bits or 4 Bytes
	0xAB, 0xCD, 0xEF, 
	

.text	#specifies text (or program segment) 
	#you need both text and data directives
	
	li 	x2, 0x43
	li	x3, 0x6000
	lw	x4, 8(x3)	#load contents of memory at 0x6000 into x4
	sw	x4, 12(x3)