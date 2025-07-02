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

# include $(TOOL_DIR)/bintools.mk   # Convenience rules for binary inspection.
@am__include@ @am__quote@$(top_srcdir)/tools/bintools.mk

# List the files to include in the export bundle, if any.

BUNDLE_FILES = build.mk

BUNDLE_TOOLS =

##
## Common deffinitons for example directories, not related to the examples.
##

include $(top_srcdir)/tools/example.mk
# @am__include@ @am__quote@$(top_srcdir)/tools/example.mk


