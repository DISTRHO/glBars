#!/usr/bin/make -f
# Makefile for DISTRHO Plugins #
# ---------------------------- #
# Created by falkTX
#

include dpf/Makefile.base.mk

all: dgl plugins gen

# --------------------------------------------------------------

dgl:
	$(MAKE) -C dpf/dgl opengl USE_FILE_BROWSER=false

plugins: dgl
	$(MAKE) all -C plugins/glBars

ifneq ($(CROSS_COMPILING),true)
gen: plugins dpf/utils/lv2_ttl_generator
	@$(CURDIR)/dpf/utils/generate-ttl.sh

dpf/utils/lv2_ttl_generator:
	$(MAKE) -C dpf/utils/lv2-ttl-generator
else
gen:
endif

# --------------------------------------------------------------

clean:
	$(MAKE) clean -C dpf/dgl
	$(MAKE) clean -C dpf/utils/lv2-ttl-generator
	$(MAKE) clean -C plugins/glBars
	rm -rf bin build

# --------------------------------------------------------------

.PHONY: plugins
