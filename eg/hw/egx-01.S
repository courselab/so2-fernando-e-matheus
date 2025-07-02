#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#   
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

	## Boot, say hello, and loop forever
	## NASM assembly, neater version wit loop

	.intel_syntax noprefix

	.code16		        # Set 16-bit mode
	

begin:	
	mov ah, 0xe		# BIOS tty mode

	mov si, 0		# May be 0 because org directive.
loop:				
	mov al, [msg + si]	# Ofsset to the message
	cmp al, 0x0		# Loop while char is not 0x0 
	je halt			# Jump to halt
	int 0x10		# Call BIOS video interrupt
	add si, 0x1		# Point to the next character
	jmp loop		# Repeat until we find a 0x0

halt:
	hlt			# Halt
	jmp halt		# Safeguard

msg:				# C-like NULL terminated string

	.string "Hello World"
	
	.fill 510 - (.- begin), 1, 0	# Pad with zeros
	.word 0xaa55		# Boot signature

		
