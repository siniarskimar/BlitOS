SOURCE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

loader_TARGET := $(BUILD_ROOT)/loader/blitload.elf

loader_INCDIRS :=\
$(SOURCE_ROOT) \
$(SOURCE_ROOT)/include

loader_CFLAGS :=\
$(CFLAGS) \
-ffreestanding \
-nostdlib \
-mno-red-zone \
$(patsubst %,-I%,$(loader_INCDIRS))

loader_SRC :=\
$(SOURCE_DIR)/start.S

.PHONY: loader
loader: $(loader_TARGET)

include $(SOURCE_DIR)/arch/$(ARCH)/.build.mk