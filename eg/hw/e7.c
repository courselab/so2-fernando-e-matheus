/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.
 */

int __attribute__((fastcall)) printf(const char*); /* Calling convention. */

int main(void)   
{
  printf ("Hello World");
  return 0;
}





