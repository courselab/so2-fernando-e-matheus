	.code16                # Set 16-bit code

        .global start          # Linker needs the entry point

_start:	                        # Entry point (and no $$)

        mov   $0xe, %ah        # BIOS tty mode

        mov   $0x0, %bx        # Using linker's org flag

loop:
        mov   msg(%bx), %al    # Offset to the message
        cmp   $0x0, %al        # Loop while char is not 0x0
        je    halt             # Jump to halt
        int   $0x10            # Call bios
        add   $0x1, %bx        # Point to the next character
        jmp   loop             # Repeat until we find a 0x0

halt:
        hlt                    # Halt
        jmp   halt             # Safeguard

msg:                           # NULL terminated string

        .string    "Hello World"

        .fill 510 - (. - _start), 1, 0      # Pad with zeros
        .word 0xaa55      
