# for(i=0; i<10; i++)     i is x3
#	a = a+2;	  a is x5

	li	x3, 0 		#initialize loop count
	li	x4, 10 		#initialize end condition
loop:	bge 	x3, x4, endloop
	addi	x5, x5, 2	#what to do in the loop
	addi	x3, x3, 1 	#increment i (i++)
	j	loop
	
endloop:
