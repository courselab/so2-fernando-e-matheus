dnl    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
dnl
dnl    >> Usage hint:
dnl
dnl       If you're looking for a file such as README or Makefile, then this one 
dnl       you are reading now is probably not the file you are interested in. This
dnl       and other files named with suffix '.m4' are source files used by SYSeg
dnl       to create the actual documentation files, scripts and other items they
dnl       refer to. If you can't find a corresponding file without the '.m4' name
dnl       extension in this same directory, then chances are that you have missed
dnl       the build instructions in the README file at the top of SYSeg's source
dnl       tree (yep, it's called README for a reason).

include(docm4.m4)

 Bare-Metal Hello World
 ==============================================

 This activity is meant for practicing the concepts and techniques addressed by
 the series of examples in section 'syseg/eg/hw'.

 Challenge
 ------------------------------
 
 1) Build and test the program:

    	  make hello.bin
	  make hello.bin/run

 2) Study the code and understand how it works.

 3) Implement a test a new function.

    a) Add a new function to libc.S that uses the BIOS service [1].

       For example, you can get the conventional memory size (int 0x12), or the
       real-time clock info (int 0x1a). Tip: make your function return the value
       in %ax (as does GCC); then convert from integer to string in C.
    
    b) Call the function from main().

       Call your function and print the result.

    c) Edit the Makefile accordingly.

    d) Explain your implementation in a text file named SOLVED.
    	
	 
 Reference
 ------------------------------

 [1] https://en.wikipedia.org/wiki/BIOS_interrupt_call

dnl DOCM4_EXERCISE_DIRECTIONS

 DOCM4_BINTOOLS_DOC
