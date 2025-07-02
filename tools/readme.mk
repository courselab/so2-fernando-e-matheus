#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

all : README

README : README.m4
	m4 --include=$(TOOL_DIR) $< > $@
	$(TOOL_DIR)/syseg-reuse $@
