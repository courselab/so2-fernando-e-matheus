#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#    SPDX-FileCopyrightText: 2025 matheusines <matheus.ines@gmail.com>
#   
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#  This file is a derivative of SYSeg (https://gitlab.com/monaco/syseg)
#  and includes modifications made by the following author(s):
#  matheusines <matheus.ines@gmail.com>

CC=gcc
MAKE=make

dos=$(shell basename $$(realpath .))
dos = mfdos
# Build the OS and an example user program.

# Link all objects needed by the OS.

$(dos).bin : bootloader.o bios1.o kernel.o kaux.o bios2.o logo.o syscall.o tyfs.o
	ld -melf_i386 -T tydos.ld --orphan-handling=discard $^ -o $@

# Here we are statically linking the user program 'prob.bin' into the kernel,
# so as to simulate the execution of a user program. If we were to actually load
# and execute an external program, we should remove 'prog.o' and 'libtydos.o'
# from the list of pre-requisites, and edit the linker script accordingly.
# Comment out the following line if this is the case.

$(dos).bin : prog.o libtydos.o

# Rules to build objects from either C or assembly code.

%.o : %.c
	gcc -m16 -O0 --freestanding -fno-pic $(NO_CF_PROTECT) -c  $< -o $@

%.o : %.S
	as -32 $< -o $@

bootloader.o : bios1.h kernel.h
kernel.o : bios1.h bios2.h kernel.h kaux.h
kaux.o:    bios2.h kaux.h

$(dos).bin : .EXTRA_PREREQS = rt0.o tydos.ld

# Rules to build the user programs
# You would add new programs to this variable if bulding other user programs.
# The user library is automatically added by the linker script.

progs = prog.bin

$(progs)  : %.bin : %.o libtydos.a
	ld -melf_i386 -T prog.ld --orphan-handling=discard $< -o $@

$(progs:%.bin=%.o) : %.o : %.c tydos.h
	gcc -m16 -O0 --freestanding -fno-pic $(NO_CF_PROTECT) -c $< -o $@

$(progs:%.bin=%.o) : tydos.h

$(progs:%.bin=%.o) : .EXTRA_PREREQS = prog.ld

# Recipes to build the user library.

libtydos.o: libtydos.c tydos.h
	gcc -m16 -O0 --freestanding -fno-pic $(NO_CF_PROTECT) -c  $< -o $@

libtydos.o : tydos.h

libtydos.a : libtydos.o
	ar rcs $@ $^

#----------------------------------------------------
#Disk image

reserverd_blocks = 30

tyfsedit : tyfsedit.c
		gcc tyfsedit.c -lm -o tyfsedit

disk.img : tyfsedit
		dd if=/dev/zero of=disk.img count=2880
		./format -r $(reserverd_blocks) disk.img
		dd if=mfdos.bin of=disk.img conv=notrunc obs=1 seek=16
		./put file1.txt disk.img
		./put file2.txt disk.img
		./put file3.txt disk.img


#----------------------------------------------------

# Housekeeping.

.PHONY: clean

clean:
	
	rm -f *.bin *.o *~ *.s *.a *.img
# SYSeg's  convenience rules (not related to the example itself)
include bintools.mk
