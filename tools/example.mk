#    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
#
#    SPDX-License-Identifier: GPL-3.0-or-later
#
#    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

## These are axiliary rules used by SYSeg for regular development and
## maintenance, and are not related to the code example itself.
## You probably don't need to modify anything bellow this line.
##
## Notes: this file is include by the Makefile.am script pertaining to each
## example directory under SYSeg.

## Include the example-specific rules (usually, build.mk).

include $(BUILDRULES)

## Build the example-specific documentation.

all :
	@echo "Targets must be built manually. See README for details."

README : README.m4
	m4 --include=$(TOOL_DIR) $< > $@
	$(TOOL_DIR)/syseg-reuse $@

.EXTRA_PREREQS = README

## Clean extra files

BUNDLE=$$(basename $$(pwd))

clean-bundle:
	rm -rf $(BUNDLE) $(BUNDLE).tar.gz

clean-all: clean clean-bundle
	rm -rf README

distclean-local: clean-all
	$(MAKE) -f $(BUILDRULES) clean

# *** TODO: fix doc to replace make export with make bundle

#BUNDLE_FILES += COPYING

bundle : $(BUNDLE_FILES)
	rm -rf $(BUNDLE)
	mkdir $(BUNDLE)
	for i in $(BUNDLE_FILES); do\
	  $(TOOL_DIR)/syseg-export $$i $(BUNDLE);\
	done
	for i in $(EXPORT_NEW_FILES); do\
	  $(TOOL_DIR)/syseg-newfile -c $(BUNDLE)/$$i;\
	done

	tmpfile=$$(mktemp -p . --suffix=.mk);\
	echo "CC=$(CC)" >> $$tmpfile;\
	echo "MAKE=$(MAKE)" >> $$tmpfile;\
	echo "" >> $$tmpfile;\
	sed '1,/^[[:blank:]]*$$/ { /^[^#]/q; d; }' $(BUILDRULES) >> $$tmpfile;\
	cat $(BUILDRULES) >> $$tmpfile;\
	$(TOOL_DIR)/syseg-reuse -y $(COPYRIGHT_YEAR) $$tmpfile;\
	$(TOOL_DIR)/syseg-export $$tmpfile $(BUNDLE);\
	mv $(BUNDLE)/$$tmpfile $(BUNDLE)/Makefile;\
	rm -f $$tmpfile


	if test -n "$(BUNDLE_TOOLS)"; then\
	  echo "# SYSeg's  convenience rules (not related to the example itself)" >> $(BUNDLE)/Makefile;\
	fi
	for file in "$(BUNDLE_TOOLS)"; do\
	  cp $(TOOL_DIR)/$$file $(BUNDLE);\
	  echo "include $$file" >> $(BUNDLE)/Makefile;\
	done


	$(AMTAR) -cf $(BUNDLE).tar $(BUNDLE)
	if test $(has_gzip) == 'yes'; then\
	  gzip -f $(BUNDLE).tar;\
	else\
	  echo "Gzip not found; left uncompressed";\
	fi


