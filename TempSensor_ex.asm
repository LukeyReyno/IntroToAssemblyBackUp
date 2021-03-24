#######################
# Temp Sensor Program Example
# Lucas Reyna
# 1/13/2021
#######################

.eqv 	TEMP_SENSOR, 	0x11000000
.eqv	LEDS, 		0x11000020
.eqv	TOO_HOT, 		100
.eqv	ON, 		0xFFFFFFFF

#initialize registers
		li 	x1, TEMP_SENSOR
		li 	x2, LEDS
		li 	x3, TOO_HOT
		li	x4, ON
		li	x6, 105
		sw	x6, (x1)
#read from Temperature sensor
Main:		lw	x5, 0(x1)

#check if temp > 100
		bgt	x5, x3, turn_on
#temp is less than 100
		sw	x0, 0(x2) #turn off LEDS
		j	Main


turn_on:	sw	x4, 0(x2)  #put on value into LEDS
		j	Main
