dnl    SPDX-FileCopyrightText: 2024 Monaco F. J. <monaco@usp.br>
dnl
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

include(docm4.m4)dnl

DOCM4_RELEVANT_RULES

# By default, the bootable program name will by $(dosname).bin
# If you export this directory to extend the example as part of a programming
# exercise, redefine $(dos) to reflect your own DOS name, say
# dos = "amazingOS"
# Rules to build objects from either C or assembly code.

%.o : %.c
	gcc -m16 -O0 --freestanding -fno-pic NO_CF_PROTECT -c $(CFLAGS) $< -o $@

%.o : %.S
	as -32 $< -o $@
	ld -melf_i386 -T prog.ld --orphan-handling=discard $< -o $@

$(progs:%.bin=%.o) : %.o : %.c tydos.h
	gcc -m16 -O0 --freestanding -fno-pic NO_CF_PROTECT -c $(CFLAGS) $< -o $@

$(progs:%.bin=%.o) : tydos.h

# Recipes to build the user library.

libtydos.o: libtydos.c tydos.h
	gcc -m16 -O0 --freestanding -fno-pic NO_CF_PROTECT -c $(CFLAGS) $< -o $@

libtydos.o : tydos.h


clean:
	rm -f *.bin *.o *~ *.s *.a

dnl
dnl Uncomment to include bintools
dnl
dnl
DOCM4_BINTOOLS


EXPORT_FILES = Makefile README bootloader.c kernel.c kernel.h kaux.c kaux.h bios1.S bios1.h bios2.S bios2.h syscall.c tydos.ld  libtydos.c tydos.h tydos.h prog.c prog.ld rt0.S  logo.c
EXPORT_NEW_FILES = NOTEBOOK
DOCM4_EXPORT([$(dos)],[1.0.0])


