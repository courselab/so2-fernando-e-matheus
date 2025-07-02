dnl    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

AC_INIT([Hello],[1.0])
AM_INIT_AUTOMAKE([subdir-objects])

AC_CONFIG_HEADERS([config.h])

AC_PROG_CC

dnl AC_CONFIG_HEADERS([config.h])	

AC_CONFIG_LIBOBJ_DIR([replace])
AC_CHECK_DECLS([strdup],[], [AC_LIBOBJ(mystrdup)])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
