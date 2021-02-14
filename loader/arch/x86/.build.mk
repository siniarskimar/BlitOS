loader_SRC:=\
$(loader_SRC) \
$(SOURCE_DIR)/arch/x86/stivale.S \
$(SOURCE_DIR)/arch/x86/stivale.c

loader_OBJS := $(subst $(SOURCE_ROOT),$(BUILD_ROOT),$(patsubst %,%.o,$(loader_SRC)))
loader_LDSCRIPT := $(SOURCE_DIR)/arch/x86/link.ld

$(loader_TARGET): $(loader_OBJS) $(loader_LDSCRIPT)
	$(LD) $(loader_OBJS) -T $(loader_LDSCRIPT) -nostdlib -o $@ -lgcc

$(BUILD_ROOT)/loader/%.o: $(SOURCE_DIR)/%
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(loader_CFLAGS)