bin = eg-00.bin eg-01_alpha.bin eg-01.bin eg-02.bin eg-03.bin egx-01.bin egx-02.bin

## GAS assembly.
## We build with as and ld, using a linker script.

eg-00.o eg-01_alpha.o eg-01.o eg-01-v2.o eg-01v2.o eg-02.o eg-02-v2.o eg-02-v3.o : %.o : %.S
	as --32 $< -o $@

# eg-00.bin eg-01_alpha.bin eg-01.bin eg-02.bin eg-02-v2.bin eg-02-v3.bin : %.bin : %.o mbr.ld rt0.o
# 	ld -melf_i386 --orphan-handling=discard -T mbr.ld $(filter %.o, $^) -o $@

eg-00.bin eg-01_alpha.bin eg-01.bin eg-01-v2.bin eg-01v2.bin eg-02.bin eg-02-v2.bin eg-02-v3.bin : %.bin : %.o mbr.ld 
	ld -melf_i386 --orphan-handling=discard -T mbr.ld $(filter %.o, $^) -o $@



## C source code.
## We build the program using gcc, as and ld.

ifdef RT0
LDSCRIPT = rt0.ld
else
LDSCRIPT = mbr.ld
endif


ifdef BADORDER

eg-03.bin  : %.bin : %_utils.o %.o  $(LDSCRIPT) rt0.o
	ld -melf_i386 --orphan-handling=discard -T $(LDSCRIPT) $(filter-out %.ld rt0.o, $^) -o $@
else
eg-03.bin  : %.bin : %.o %_utils.o $(LDSCRIPT) rt0.o
	ld -melf_i386 --orphan-handling=discard -T $(LDSCRIPT) $(filter-out %.ld rt0.o, $^) -o $@
endif


eg-03.o eg-03_utils.o  : %.o: %.s
	as --32 $< -o $@

ifdef SIMPLIFY
eg-03.i eg-03_utils.i : %.i : %.c
	cpp -I. -DATTR="NAKED __attribute__((fastcall))" -DRET="__asm__(\"ret\");"  $< -o $@
else
eg-03.i eg-03_utils.i : %.i : %.c
	cpp -I. -DATTR="" -DRET="" $< -o $@
endif

# eg-03.s eg-03_utils.s  :%.s: %.c
# 	gcc -m16 -O0 -I. -Wall -fno-pic $(NO_CF_PROTECT)  -DATTR="NAKED __attribute__((fastcall))" -DRET="__asm__(\"ret\");" --freestanding -S $< -o $@

# eg-03.s eg-03_utils.s  :%.s: %.c
# 	gcc -m16 -O0 -I. -Wall -fno-pic $(NO_CF_PROTECT)  -DATTR="" -DRET="" --freestanding -S $< -o $@

eg-03.s eg-03_utils.s  :%.s: %.i
	gcc -m16 -O0 -I. -Wall -fno-pic $(NO_CF_PROTECT)  --freestanding -S $< -o $@

rt0.o : %.o : %.S
	as --32 $< -o $@

#
# Test and inspect
#

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32

#
# Extra auxiliary examples
#

egx-01.o egx-02.o : %.o : %.S
	as --32 $< -o $@

egx-01.bin egx-02.bin : %.bin : %.o mbr.ld
	ld -melf_i386 -T mbr.ld --orphan-handling=discard $(filter %.o, $^) -o $@

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*
