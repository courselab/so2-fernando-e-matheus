bin = tyfsedit

%.o : %.c
	gcc -c $(CPPFLAGS) $(CFLAGS) -Wno-unused-result $< -o $@

tyfsedit : tyfsedit.o
	gcc $< -lm -o $@

# Create a 1.44 MB floppy image (2880 * 512 bytes)

disk.img:
	rm -f $@
	dd if=/dev/zero of=$@ count=2880

.PHONY: clean img

clean:
	rm -f $(bin) *.o tyfsedit *.img

