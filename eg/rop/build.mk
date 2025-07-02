bin = eg-00 eg-00a eg-01 eg-01 eg-02 eg-03 eg-04 eg-04a eg-05 eg-06 eg-07 eg-08 eg-09

eg-00 : eg-00.c
	gcc -Wall -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-stack-protector -fno-pie -fno-pic $<  -o $@

eg-00a : eg-00a.c
	gcc -Wall -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-pic $<  -o $@

eg-01 : eg-01.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-stack-protector -mpreferred-stack-boundary=2 $<  -o $@

eg-02 : eg-02.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-stack-protector -mpreferred-stack-boundary=2 $<  -o $@

eg-03 : eg-03.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-stack-protector  $<  -o $@

eg-04 : eg-04.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-stack-protector  $<  -o $@

eg-04a : eg-04a.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-stack-protector  $<  -o $@

eg-05 : eg-05.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -no-pie $<  -o $@

eg-06 : eg-06.c
	gcc -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -no-pie $<  -o $@

eg-07 : eg-07.c
	gcc -Wall -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-pic -no-pie $<  -o $@

eg-08 : eg-08.c
	gcc -Wall -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-pie -fno-pic -no-pie $<  -o $@

eg-09 : eg-09.c
	gcc -Wall -g -m32 -Wall -Wno-unused -O0 $(NO_CF_PROTECT) -fno-stack-protector -mpreferred-stack-boundary=2 -fno-pie -fno-pic -z execstack -Wno-deprecated-declarations --ansi -no-pie $<  -o $@

eg-09.in : eg-09.bin eg-09.sh
	./eg-09.sh $<

eg-09.bin : eg-09.S
	as --32 $< -o $@.o
	ld -melf_i386 --oformat=binary -Ttext=0x0 $@.o -o $@

eg-09.elf : eg-09.S
	as --32 $< -o $@.o
	ld -melf_i386  $@.o -o $@

%/main: %
	objdump -m i386 --disassemble=main $< | sed  's/:\(\t.*\t\)/:    /g'

.PHONY: clean

clean :
	rm -f $(bin) *.o *.in *.bin *.elf
