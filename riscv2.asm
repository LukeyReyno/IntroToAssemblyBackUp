main:    lui    x1, 0x6
         ori    x2, x0, 7
         beq   x1, x2, main
         lw      x3, 0(x1) 
         j          main