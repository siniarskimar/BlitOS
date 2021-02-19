SOURCE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

kernel_TARGET := $(BUILD_ROOT)/kernel/blitkern.elf

kernel_INCDIRS :=\
$(SOURCE_ROOT) \
$(SOURCE_ROOT)/include \
$(SOURCE_DIR)/include

kernel_CFLAGS :=\
$(CFLAGS) \
-ffreestanding \
-nostdlib \
-mno-red-zone \
$(patsubst %,-I%,$(kernel_INCDIRS))

.PHONY: kernel
kernel: libk $(kernel_TARGET)

.PHONY: kernel-sysroot
kernel-sysroot: kernel
	cp $(kernel_TARGET) $(BUILD_ROOT)/sysroot/boot

include $(SOURCE_DIR)/arch/$(ARCH)/.build.mk

