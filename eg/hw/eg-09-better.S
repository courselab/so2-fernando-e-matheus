	/* Splitting main program, and lib. 

	How to make sure that the signagure comes at the right place? */

        .code16                

        .global _start	     	

	.section .text
	
_start:	                        

	mov $msg, %bx		/* Notice $msg */
	call write

halt:	
        hlt                    
        jmp   halt             

	.section .rodata

msg:                           

        .string    "Hello World"




