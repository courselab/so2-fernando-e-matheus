/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */

/*  Linker script for MBR. */

OUTPUT_FORMAT(binary)		/* Output flat binary blob. */
SECTIONS
{
        . = 0x7C00;		/* Initial memory address (BIOS legacy boot) */
	
        .text :
	{
	  *(.text)              /* Copy input section .text to the oputput. */
	  *(.rodata*)		/* Copy input section .rodata to the output. */
	}
	
        . = 0x7c00 + 510;	/* Advance 510 bytes. */
	
        .signature : 		/* Add a signadure section with this content. */
	{
	    BYTE(0x55)
            BYTE(0xAA)
        }
}

STARTUP(crt0.o);




