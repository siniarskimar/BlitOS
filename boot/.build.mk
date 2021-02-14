SOURCE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ifeq ($(BOOTLOADER),)

ifeq ($(ARCH),$(findstring $(ARCH),x86 x86_64))
default_bootloader += bootloader-limine
endif

default_bootloader := $(default_bootloader)
export BOOTLOADER :=$(firstword $(default_bootloader))
endif

.PHONY: bootloader
bootloader: $(BOOTLOADER)

.PHONY: bootloader-limine
bootloader-limine: $(SOURCE_DIR)/limine/.git $(SOURCE_DIR)/limine/limine-install

$(SOURCE_DIR)/limine/.git:
	git submodule update --init --recursive $(SOURCE_DIR)/limine
	cd $(SOURCE_DIR)/limine && git checkout v1.0.5

$(SOURCE_DIR)/limine/limine-install:
	$(MAKE) -C $(SOURCE_DIR)/limine limine-install