bin = mkfat12-beta mkfat12 vbrinfo fatinfo

# Create a FAT12 filesystem

mkfat12-beta : mkfat12-beta.o
	gcc $< -o $@

# # Creaate a FAT12 filesystem with custom bootstrap code

# mkfat12 : mkfat12.o mbs.o
# 	gcc $^ -o $@

# Inspect a FAT12/FAT16 BPB information

vbrinfo : vbrinfo.o
	gcc $< -o $@

fatinfo : fatinfo.o
	gcc $< -o $@

%.o : %.c
	gcc -c $< -o $@

mkfat12-beta mkfat12 mbrinfo : fat12.h

mbrinfo: fat.h

##
## Using the mkfat12-beta program
##

# Create a FAT12-formatted floppy disk image

fat12.img: | mkfat12-beta
        # Create the floppy disk information
	dd if=/dev/zero of=$@ count=2880
        # Write the fat information
	./mkfat12-beta $@


# Create a bootable FAT12-formatted floppy disk image.
# How about using the Hello World program we developed in eg/hw?

fat12-boot.img: hw.bin | mkfat12-beta
        # Create the floppy disk image
	dd if=/dev/zero of=$@ count=2880
        # Write the fat information
	./mkfat12-beta $@
        # Write the bootstrap program at the appropriate offset
	dd if=hw.bin of=$@ obs=1 conv=notrunc seek=62

##
## Using the full-featured mkfat12 program
##

#  The program mkfat12 creates a FAT12 filesystem on a device.
#  If a file containing a bootstrap program is specified, its contents are
#  copied verbatim to the appropriate location in the device's MBR. If such
#  a program is not specified, mkfat12 uses a default bootstrap program.

mkfat12 : mkfat12.o | mbs.bin
	gcc $< -o $@

mbs.o : mbs.S
	as --32 $< -o mbs.o

mbs.bin : mbs.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c3e -e mbs  $< -o $@

# Create a bootable FAT12-formatted floppy disk image using mkfat12.

boot12.img: mkfat12
	dd if=/dev/zero of=$@ count=2880
	./mkfat12  $@

# Create some disk-image examples and format them with
# a standard utility (mkfs, from util-linux).

img-examples: fat12-mkfs.img fat16-mkfs.img fat32-mkfs.img

fat12-mkfs.img:
	dd if=/dev/zero of=$@ count=2880
	mkfs.fat -F 12 $@

fat16-mkfs.img:
	dd if=/dev/zero of=$@ count=32768
	mkfs.fat -F 16 $@

fat32-mkfs.img:
	dd if=/dev/zero of=$@ count=131072
	mkfs.fat -F 32 $@

# Extra examples

egx-01.bin : egx-01.hex
	$(TOOL_DIR)/hex2bin $< $@

#
# Auxiliary artifacts
#

# This is the bare-metal Hello World we've developed as part of eg/hw series.
# For illustration purpose, We may use it as a boostrap code for a bootable
# FAT-formatted disk.

hw.bin : hw.ld $(addprefix ../hw/, eg-07.o eg-07_utils.o eg-07_rt0.o)
	ld -melf_i386 -T hw.ld --orphan-handling=discard  $(addprefix ../hw/, eg-07.o eg-07_utils.o) -o $@

.PHONY: $(addprefix ../hw/, eg-07.o eg-07_utils.o eg-07_rt0.o)
$(addprefix ../hw/, eg-07.o eg-07_utils.o eg-07_rt0.o) :
	make -C ../hw/ $(notdir $@)


img = fat12.img fat12-boot.img
img += fat12-mkfs.img fat16-mkfs.img fat32-mkfs.img

.PHONY: clean-local
clean-local :
	rm -f *.img *.bin mbs.c *.o $(bin)

clean : clean-local
