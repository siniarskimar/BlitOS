$(BUILD_ROOT)/arch/x86/%.o: $(SOURCE_ROOT)/arch/x86/%
	mkdir -p $(dir $@)
	$(CC) -c $^ -o $@ -ffreestanding -mno-red-zone -nostdlib -I$(SOURCE_ROOT)