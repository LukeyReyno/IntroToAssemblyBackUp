# def sumSquare (x, y):
#	result = mult(x,x) + y return result

#########################
# Function: sumSquare
# Arguments: a0-x, a1-y
# Return value: a0 - mult(x,x) + y
# Changed registers: a0, ra, a1, a2, t0
#############################
sumSquare:	addi 	sp, sp, -8 #could have been -4 to just store ra
		sw 	t0, 0(sp) #not critical
		sw 	ra, 4(sp)
		mv 	t0, a1
		mv 	a1, a0
		mv 	a2, a0
		call 	Multiply
		add 	a0, a0, t0
		lw 	t0, 0(sp) #not critical
		lw 	ra, 4(sp)
		addi 	sp, sp, 8
		ret
		
		
		
		
###########################
#Function: Multiply
#Arguments: a1-A, a2-B
#Return Value: a0 - A*B
#Changed registers: a0, a2
###########################
Multiply: 	li 	a0, 0
		beqz 	a1, endmult
multloop: 	beqz 	a2, endmult
		add 	a0, a1, a0
		addi 	a2, a2, -1
		j 	multloop
endmult: 	ret