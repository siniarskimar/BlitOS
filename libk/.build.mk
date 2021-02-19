SOURCE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

libk_TARGET := $(BUILD_ROOT)/libk/libk.a

libk_INCDIRS :=\
$(SOURCE_ROOT) \
$(SOURCE_ROOT)/include

libk_CFLAGS :=\
$(CFLAGS) \
-ffreestanding \
-nostdlib \
-mno-red-zone \
$(patsubst %,-I%,$(libk_INCDIRS))

.PHONY: libk
libk: $(libk_TARGET)

include $(SOURCE_DIR)/arch/$(ARCH)/.build.mk