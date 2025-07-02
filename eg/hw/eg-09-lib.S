	/* Splitting main program and lib. */

	
        .code16                

        .global write	     	


write:	                        

        mov   $0xe, %ah        
        mov   $0x0, %si

loop:
        mov   (%bx, %si), %al    
        cmp   $0x0, %al        
        je    end
        int   $0x10            
        add   $0x1, %si        
        jmp   loop             
	
end:
        ret      


	
