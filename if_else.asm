	li 	x4, 20 #compare value
	blt	x3, x4, iflabel
	li 	x5, 50 #else condition
	j 	skip
	
iflabel:
	li x5, 30
	
skip: