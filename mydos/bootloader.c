/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *    SPDX-FileCopyrightText: 2025 matheusines <matheus.ines@gmail.com>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *  This file is a derivative of SYSeg (https://gitlab.com/monaco/syseg)
 *  and includes modifications made by the following author(s):
 *  matheusines <matheus.ines@gmail.com>
 */

#include "bios1.h"  /* Function load_kernel . */
#include "kernel.h" /* Function kmain.        */

int boot()
{

  load_kernel(); /* Load the kernel from disk image.  */

  kmain(); /* Call the kernel's entry function. */

  return 0;
}
