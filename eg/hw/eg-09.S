	/* Splitting main program, and lib. 

	How to make sure that the signagure comes at the right place? */

        .code16                

        .global _start	     	

_start:	                        

	mov $msg, %bx		/* Notice $msg */
	call write

halt:	
        hlt                    
        jmp   halt             


msg:                           

        .string    "Hello World"

        . = 510 - _start
        .word 0xaa55



