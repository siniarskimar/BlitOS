MAKEFLAGS += -r
DEFAULT_GOAL := all

export SOURCE_ROOT := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ifeq ($(BUILD_ROOT),)
$(error Missing variable BUILD_ROOT)
endif

ifeq ($(wildcard $(BUILD_ROOT)),)
$(shell mkdir $(BUILD_ROOT))
endif
export BUILD_ROOT := $(patsubst %/,%,$(BUILD_ROOT))

$(info Source root: $(SOURCE_ROOT))
$(info Build root: $(BUILD_ROOT))

.PHONY: all
all: loader kernel
	@echo ======= Compilation complete

include $(SOURCE_ROOT)/loader/.build.mk
include $(SOURCE_ROOT)/kernel/.build.mk
