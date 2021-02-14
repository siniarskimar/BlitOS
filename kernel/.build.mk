SOURCE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

kernel_TARGET := $(BUILD_ROOT)/kernel/blitkern.elf

kernel_INCDIRS :=\
$(SOURCE_ROOT) \
$(SOURCE_ROOT)/include

kernel_CFLAGS :=\
$(CFLAGS) \
-ffreestanding \
-nostdlib \
-mno-red-zone \
$(patsubst %,-I%,$(kernel_INCDIRS))

.PHONY: kernel
kernel: $(kernel_TARGET)

include $(SOURCE_DIR)/arch/$(ARCH)/.build.mk

