/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */


OUTPUT_FORMAT(binary)		/* Output flat binary (no structure). */
SECTIONS
{
        . = 0x7C00;		/* Line counter is now 0x7c00. */

	.bootloader :
	{
	  rt0.o(.text) bootloader.o(.text) bios1.o(.text)
	  rt0.o(.rodata) bootloader.o(.rodata) bios1.o(.rodata)
	  rt0.o(.data) bootloader.o(.data) bios1.o(.data)
	  rt0.o(.bss) bootloader.o(.bss) bios1.o(.bss)
	}

	. = 0x7c00 + 510;	/* Advance 510 bytes. */

        .signature : 		/* Add a signadure section with this content. */
	{
	    BYTE(0x55)
            BYTE(0xAA)
        }

	_KERNEL_ADDR = .;	/* Byte count as far as here. */

	.kernel :
	{
	  kernel.o (.text .data .bss .rodata)
	}

	_KERNEL_SIZE = . - _KERNEL_ADDR; /* This is the kernel size. */

	_END_STACK = 0x7c00;

}
STARTUP(rt0.o)			 /* Prepend with the start file. */




