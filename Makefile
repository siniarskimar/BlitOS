MAKEFLAGS += -r
DEFAULT_GOAL := all

export SOURCE_ROOT := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
export BUILD_ROOT ?= $(SOURCE_ROOT)/build

ifeq ($(wildcard $(BUILD_ROOT)),)
$(shell mkdir $(BUILD_ROOT))
endif
export BUILD_ROOT := $(patsubst %/,%,$(BUILD_ROOT))

$(info Source root: $(SOURCE_ROOT))
$(info Build root: $(BUILD_ROOT))

.PHONY: all
all: kernel
	@echo ======= Compilation complete

.PHONY: sysroot
sysroot: sysroot-dirs kernel-sysroot
	cp -r $(wildcard $(SOURCE_ROOT)/sysroot/*) -t $(BUILD_ROOT)/sysroot/

.PHONY: sysroot-dirs
sysroot-dirs:
	mkdir -p $(subst $(SOURCE_ROOT),$(BUILD_ROOT),$(dir $(wildcard $(SOURCE_ROOT)/sysroot/**/* $(SOURCE_ROOT)/sysroot/*)))

.PHONY: img
img: $(BUILD_ROOT)/blit.img all sysroot
	@echo !===========!
	@echo Creation of raw disk image requires use of sudo
	@echo !===========!
	sudo $(SOURCE_ROOT)/scripts/make_image.sh $< $(BUILD_ROOT)/sysroot/

$(BUILD_ROOT)/blit.img:
	dd if=/dev/zero of=$@ bs=1M count=128
	parted $@ mktable msdos
	parted $@ mkpart primary fat32 2048 100%

include $(SOURCE_ROOT)/loader/.build.mk
include $(SOURCE_ROOT)/kernel/.build.mk
