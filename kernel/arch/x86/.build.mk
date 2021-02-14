kernel_SRC :=\
$(SOURCE_DIR)/arch/x86/crt/crt0.S

CRTBEGIN_OBJ := $(shell $(CC) $(kernel_CFLAGS) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $(CC) $(kernel_CFLAGS) -print-file-name=crtend.o)

ifeq ($(CRTBEGIN_OBJ),)
$(error Missing crtbegin.o! Most likely a broken compiler!)
endif
ifeq ($(CRTEND_OBJ),)
$(error Missing crtend.o! Most likely a broken compiler!)
endif

kernel_OBJS :=\
$(BUILD_ROOT)/kernel/arch/x86/crt/crti.o \
$(CRTBEGIN_OBJ) \
$(subst $(SOURCE_ROOT),$(BUILD_ROOT),$(patsubst %,%.o,$(kernel_SRC))) \
$(BUILD_ROOT)/kernel/arch/x86/crt/crtn.o \
$(CRTEND_OBJ)

kernel_LDSCRIPT := $(SOURCE_DIR)/arch/x86/link.ld

$(info $(kernel_OBJS))

$(kernel_TARGET): $(kernel_OBJS) $(kernel_LDSCRIPT)
	$(LD) $(kernel_OBJS) -T $(kernel_LDSCRIPT) -nostdlib -o $@ -lgcc

$(BUILD_ROOT)/kernel/%.o: $(SOURCE_DIR)/%
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(kernel_CFLAGS)

$(BUILD_ROOT)/kernel/arch/x86/crt/crti.o: $(SOURCE_DIR)/arch/x86/crt/crti.S
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(kernel_CFLAGS)
	
$(BUILD_ROOT)/kernel/arch/x86/crt/crtn.o: $(SOURCE_DIR)/arch/x86/crt/crtn.S
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(kernel_CFLAGS)