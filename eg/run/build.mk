bin = eg-01 eg-02-static eg-02-rel eg-02-pic

WARN = -Wall -Wno-unused-result -Wno-parentheses

CPP_FLAGS=  $(WARN) $(CPPFLAGS)
C_FLAGS= -Og -m32 $(NO_CF_PROTECT)  $(CFLAGS) -O0
LD_FLAGS= -m32 $(LDFLAGS)

#
# eg-01
#

eg-01.o : eg-01.c
	gcc -c $(CPP_FLAGS) $(C_FLAGS) $< -o $@

eg-01 : eg-01.o
	gcc $(LD_FLAGS) $< -o $@

#
# eg-02
#

eg-02-static.o eg-02a-static.o: %-static.o : %.c
	gcc -c -fno-pic -fno-pie $(CPP_FLAGS) $(C_FLAGS) $< -o $@

libeg-02.a : eg-02a-static.o
	ar -rcs $@ $^

eg-02-static : eg-02-static.o libeg-02.a
	gcc -no-pie $(LD_FLAGS) -L.  eg-02-static.o -leg-02 -o $@

#

eg-02-rel.o eg-02a-rel.o: %-rel.o : %.c
	gcc -c -fno-pic -fno-pie $(CPP_FLAGS) $(C_FLAGS) $< -o $@

libeg-02-rel.so : eg-02a-rel.o
	gcc --shared -fno-pic $(LD_FLAGS) $^ -o $@

eg-02-rel : eg-02-rel.o libeg-02-rel.so
	gcc $(LD_FLAGS)  -L. eg-02-rel.o  -leg-02-rel -fno-pic -fno-pie -o eg-02-rel

#

eg-02-pic.o eg-02a-pic.o eg-02b-pic.o : %-pic.o : %.c
	gcc -c -fpic -fpie $(CPP_FLAGS) $(C_FLAGS) $< -o $@

libeg-02-pic.so : eg-02a-pic.o
	gcc --shared -fpic $(LD_FLAGS) $^ -o $@

eg-02-pic : eg-02-pic.o libeg-02-pic.so
	gcc $(LD_FLAGS)  -L. eg-02-pic.o  -leg-02-pic -fpic -fpie -o eg-02-pic


libother.so : eg-02b-pic.o
	gcc --shared -fpic $(LD_FLAGS) $^ -o $@

# eg-03 (another rel / pic example)

lib03-rel.so: eg-03-rel.o
	gcc -m32 --shared eg-03-rel.o -o lib03-rel.so

lib03-pic.so: eg-03-pic.o
	gcc -m32 --shared eg-03-pic.o -o lib03-pic.so

eg-03-rel.o : eg-03.c
	gcc -m32 eg-03.c -fno-pic -c -o eg-03-rel.o

eg-03-pic.o : eg-03.c
	gcc -m32 eg-03.c -fpic -c -o eg-03-pic.o

# p1/p2 (LD_PRELOAD example)

p1 : p1.c
	gcc -fno-builtin-printf -o p1 p1.c

libp2.so : p2.c
	gcc --shared -fPIC p2.c -o libp2.so



##
## Housekeeping
##

.PHONY: clean ps
clean:
	rm -f $(bin)
	rm -f *.a *.so *.d *.o
	rm -f p1

# Local rules

ps:
	while true; do ps axf | grep "$(TERM)" ; sleep 1; clear; done


