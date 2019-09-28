# Source and build files
SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%,$(CLANG_BLD_DIR)/%,$(SOURCES:.c=.bc))
DEPS    := $(OBJECTS:.bc=.d)
LIB     := lib$(PROJECT)
BIN     := $(CLANG_BLD_DIR)/$(LIB).a.bc


# Build flags
INCLUDES += \
	-I $(GCC_DIR)/include \
	-I $(GCC_DIR)/lib/gcc/msp430-elf/6.4.0/include \
	-I $(GCC_DIR)/msp430-elf/include \
	-I ./include

CFLAGS += \
	-emit-llvm \
	--target=msp430 \
	-D__$(DEVICE_UC)__ \
	-nobuiltininc \
	-nostdinc++ \
	-isysroot \
	/none \
	-O0 \
	-g \
	-Wall \
	-MD \
	$(DEFINES)

.PHONY: all dirs clean

all: dirs $(BIN)

dirs:
	@mkdir -p $(CLANG_BLD_DIR)

$(BIN): $(OBJECTS)
	$(V) $(LLVM_LINK) -o $(BIN) $(OBJECTS)
	$(VECHO) "Built $(LIB).a.bc"
	$(VECHO) ""

-include $(DEPS)

$(CLANG_BLD_DIR)/%.bc: $(SRC_DIR)/%.c
	$(V) $(LLVM_CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@rm -rf $(CLANG_BLD_DIR)
