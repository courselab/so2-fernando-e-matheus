#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

##
## Example directory setup.
##

# Build rules specifics to the example in this directory.

BUILDRULES = build.mk

# Uncomment to include optional tools in the Makefile.

include $(TOOL_DIR)/bintools.mk   # Convenience rules for binary inspection.

# List the files to include in the export bundle, if any.

BUNDLE_FILES = bios1.h  bios2.S  debug.h  kernel.c    logo.c  prog.ld    rt0.S      tydos.ld bios1.S  bootloader.c  kaux.c   kernel.h    Makefile     README     syscall.c bios2.h  build.mk  kaux.h   libtydos.c   prog.c  tydos.h

BUNDLE_TOOLS  = bintools.mk

##
## Common deffinitons for example directories, not related to the examples.
##

include $(TOOL_DIR)/example.mk


