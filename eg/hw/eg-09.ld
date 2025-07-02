/* Linker script for eg-09-fix.bin */

SECTIONS
{
	.text :
	{
	  *
	}	
        . = 0x7c00 + 510;	/* Advance 510 bytes. */
        .signature : 		/* Add a signadure section with this content. */
	{
	    BYTE(0x55)
            BYTE(0xAA)
        }
}
