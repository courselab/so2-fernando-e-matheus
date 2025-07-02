/* Linker script for eg-09-fix.bin */

OUTPUT_FORMAT(binary)		/* Output flat binary (no structure) */
SECTIONS
{
	. = 0x7c00;
	.text :
	{
	  *(.text)              /* Copy input section .text to the oputput. */
	  *(.rodata)		/* Copy input section .rodata to the output. */
	}	
        . = 0x7c00 + 510;	/* Advance 510 bytes. */
        .signature : 		/* Add a signadure section with this content. */
	{
	    BYTE(0x55)
            BYTE(0xAA)
        }
}
