boot.bin : bootloader.o bios1.o kernel.o 
	ld -melf_i386 -T boot.ld --orphan-handling=discard $^ -o $@

boot2.bin : bootloader.o bios1.o kernel2.o bounce.o bios2.o
	ld -melf_i386 -T boot2.ld --orphan-handling=discard $^ -o $@

%.o : %.c
	gcc -m16 -O0 --freestanding -fno-pic $(NO_CF_PROTECT) -c  $< -o $@

%.o : %.S
	as -32 $< -o $@

bootloader.o : bios1.h kernel.h
kernel.o : bios1.h 
bounce.o   : bios2.h bounce.h

boot.bin : .EXTRA_PREREQS = rt0.o boot.ld
boot2.bin : .EXTRA_PREREQS = rt0.o boot2.ld

.PHONY: clean

clean:
	rm -f *.bin *.o *~
