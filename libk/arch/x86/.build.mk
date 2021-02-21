libk_SRC :=\
arch/x86/log/e9print.c \
libk/arch/x86/log.c

libk_OBJS := $(patsubst %,$(BUILD_ROOT)/%.o,$(libk_SRC))

$(libk_TARGET): $(libk_OBJS)
	$(AR) rcs $@ $^

$(BUILD_ROOT)/libk/%.o: $(SOURCE_ROOT)/libk/%
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ $(libk_CFLAGS)