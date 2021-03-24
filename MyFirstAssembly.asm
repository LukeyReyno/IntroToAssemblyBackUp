##########################
# My first assembly program
# By: Lucas Reyna
# Date: 1/8/21
# x1 = (x3-x2) + (x5-x6) + 8
##########################

#Main:             add x3, x2, x1
#		  addi x1, x3, 20
#		  #j	Main
#		  jal x0, Main

	li 	x2, 3 #load immediate (li) 
	li	x3, 5
	li	x5, 7
	li	x6, 8

Main: 	sub 	x4, x3, x2 #x4 = (x3-x2)
	sub	x7, x5, x6 #x7 = (x5-x6)
	add	x1, x4, x7 #x1 = (x4+x7)
	addi 	x1, x1, 8  #x1 = x1 + 8
	
End: 	j 	End
