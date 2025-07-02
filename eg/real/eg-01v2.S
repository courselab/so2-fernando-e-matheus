       .code16

_start:

        cli                          
        ljmp $0x0,$init0             
init0:                               
        xorw %ax, %ax                
        movw %ax, %ds                
        movw %ax, %es                
        movw %ax, %fs                
        movw %ax, %gs                
        movw %ax, %ss                
        mov $0x7c00, %sp      
        sti                        

        mov $0x0, %si

        mov $0xb800, %ax
        mov %ax, %es               

        movb msg, %al
        movb %al, %es:(%si)        
        movb $0x20, %es:1(%si)

halt:
        hlt
        jmp halt

msg:
        .string "Hello World"
