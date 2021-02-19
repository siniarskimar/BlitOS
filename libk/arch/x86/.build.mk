libk_SRC :=\
$(SOURCE_ROOT)/arch/x86/log/e9print.c \
$(SOURCE_DIR)/arch/x86/log.c

libk_OBJS := $(subst $(SOURCE_ROOT),$(BUILD_ROOT),$(patsubst %,%.o,$(libk_SRC)))

$(libk_TARGET): $(libk_OBJS)
	$(AR) rcs $@ $^

$(BUILD_ROOT)/libk/%.o: $(SOURCE_ROOT)/libk/%
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(libk_CFLAGS)