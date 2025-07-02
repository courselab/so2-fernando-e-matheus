/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */

const char msg[]  = "Hello world";

void __attribute__((fastcall)) printf(const char*); /* Calling convention. */

void _start()   
{
  printf (msg);
}





