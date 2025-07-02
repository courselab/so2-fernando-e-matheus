#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

# These are the build rules specific to the example in this directory.

bin = main

main : main.o
	$(CC) $< -o $@

# .c.o :
# 	$(CC) -c $< -o $@

clean:
	rm -f $(bin) *.o

%.o : %.c
	$(CC) -c $< -o $@



