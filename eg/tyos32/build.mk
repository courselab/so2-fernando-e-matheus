##
## Stage 1: boot loader
## Stage 2: kernel
##

bin = boot.img

# Stage 1 uses some basic functions implemented in utils.c

bootloader_obj = bootloader.o utils.o

# Stage 2 also uses utils.c, but includes a lot more implemented in tyos.c

kernel_obj = kernel.o

# Size of kernel in 512-byte sectors

##
## First and second stage, plus auxiliary items.
##

boot_obj = bootloader.o kernel.o utils.o init32.o

boot.bin : $(boot_obj) boot.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T boot.ld $(boot_obj) -o $@

bootloader.o utils.o  : %.o: %.c
	gcc -m16 -O0 -I. -Wall -fno-pic $(NO_CF_PROTECT)  --freestanding -c $<  -o $@

kernel.o : %.o : %.c
	gcc -m32 -O0 -I. -Wall -fno-pic $(NO_CF_PROTECT)  --freestanding -c $<  -o $@

init32.o : init32.S
	as -32 $< -o $@

k.o : k.S
	as -32 $< -o $@

bootloader.o kernel.o utils.o  : utils.h
kernel.o :

rt0.o : rt0.S
	gcc -m16 -O0 -Wall -c $< -o $@

# gdt.o : gdt.S
# 	as -32 $< -o $@

# init32.o : init32.c
# 	gcc -m32 -c $(C_FLAGS) $< -o $@

# Create a 1.44M floppy disk image (which is actually 1440 KB)

floppy.img: boot.bin
	rm -f $@
	dd bs=512 count=2880 if=/dev/zero of=$@ # Dummy 1440 kB floppy image.
	mkfs.fat -R 2 floppy.img

# Write boot.bin at begining of the floppy image.

boot.img : boot.bin floppy.img
	cp floppy.img $@
	dd conv=notrunc ibs=1 obs=1 skip=62 seek=62 if=boot.bin of=$@

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*

