##
## Stage 1: boot loader
## Stage 2: kernel
##

bin = boot.img

# Stage 1 uses some basic functions implemented in utils.c

bootloader_obj = bootloader.o utils.o

# Stage 2 also uses utils.c, but includes a lot more implemented in tyos.c

kernel_obj = kernel.o syscall.o

# Size of kernel in 512-byte sectors

KERNEL_SIZE=1


AUXDIR =../../tools

##
## First and second stage, plus auxiliary items.
##

boot_obj = bootloader.o kernel.o utils.o syscall.o runtime.o

boot.bin : $(boot_obj) boot.ld rt0.o
	ld -melf_i386 --orphan-handling=discard  -T boot.ld $(boot_obj) -o $@

bootloader.o kernel.o utils.o syscall.o runtime.o : %.o: %.c
	gcc -m16 -O0 -I. -Wall -fno-pic -fcf-protection=none  --freestanding -c $<  -o $@

bootloader.o kernel.o utils.o  : utils.h
kernel.o syscall.o runtime.o : syscall.h

rt0.o : rt0.S
	gcc -m16 -O0 -Wall -c $< -o $@

# Create a 1.44M floppy disk image (which is actually 1440 KB)

floppy.img: boot.bin
	rm -f $@
	dd bs=512 count=2880 if=/dev/zero of=$@ # Dummy 1440 kB floppy image.
	mkfs.fat -R 2 floppy.img

# Write boot.bin at begining of the floppy image.

boot.img : boot.bin floppy.img
	cp floppy.img $@
	dd conv=notrunc ibs=1 obs=1 skip=62 seek=62 if=boot.bin of=$@


# losetup

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*

