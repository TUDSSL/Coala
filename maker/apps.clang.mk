# Source and build files
SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%,$(CLANG_BLD_DIR)/%,$(SOURCES:.c=.bc))
DEPS    := $(OBJECTS:.bc=.d)
BIN     := $(CLANG_BLD_DIR)/$(PROJECT).out
BC      := $(CLANG_BLD_DIR)/$(PROJECT).a.bc
ASM     := $(CLANG_BLD_DIR)/$(PROJECT).S

MAKE    := make

# Build flags

# Possible control defines:
# ENABLE_PRF -> enable GPIO toggling for profiling
# AUTO_RST   -> enable timed MCU reset
# RST_TIME   -> base reset time (clock cycles)
# TSK_SIZ    -> enable profiling using built-in timer
# LOG_INFO   -> print debugging information
DEFINES += \
	-DENABLE_PRF=1 \
	-DAUTO_RST=1 \
	-DRST_TIME=50000 \
	-DTSK_SIZ=0 \
	-DLOG_INFO=0

INCLUDES += \
	-I ./ \
	-I $(GCC_DIR)/include \
	-I $(GCC_DIR)/lib/gcc/msp430-elf/6.4.0/include \
	-I $(GCC_DIR)/msp430-elf/include \
	-I $(LIB_DIR)/mspDebugger/include \
	-I $(LIB_DIR)/mspProfiler/include \
	-I $(LIB_DIR)/mspReseter/include \
	-I $(LIB_DIR)/mspprintf/include \
	-I $(LIB_DIR)/mspbase/include \
	-I $(COALA_DIR)/include

CFLAGS += \
	-emit-llvm \
	--target=msp430 \
	-D__$(DEVICE_UC)__ \
	-nobuiltininc \
	-nostdinc++ \
	-isysroot \
	/none \
	-O0 \
	-std=c99\
	-g \
	-Wall \
	-MD \
	$(DEFINES)

LFLAGS += \
	-Wl,-Map=$(CLANG_BLD_DIR)/$(PROJECT).map \
	-T $(LSC_DIR)/$(DEVICE).ld \
	-L $(GCC_DIR)/include \
	-L $(LIB_DIR)/mspDebugger/build \
	-L $(LIB_DIR)/mspProfiler/build \
	-L $(LIB_DIR)/mspReseter/build \
	-L $(LIB_DIR)/mspprintf/build \
	-L $(LIB_DIR)/mspbase/build \
	-L $(LIB_DIR)/mspmath/build \
	-L $(COALA_DIR)/build

LIBS += \
	-lcoala \
	-lmspdebugger \
	-lmspprofiler \
	-lmspreseter \
	-lmspprintf \
	-lmspbuiltins

LLVM_LIBS += \
	$(COALA_DIR)/build_clang/libcoala.a.bc \
	$(LIB_DIR)/mspdebugger/build_clang/libmspdebugger.a.bc \
	$(LIB_DIR)/mspprofiler/build_clang/libmspprofiler.a.bc \
	$(LIB_DIR)/mspreseter/build_clang/libmspreseter.a.bc \
	$(LIB_DIR)/mspprintf/build_clang/libmspprintf.a.bc \
	$(LIB_DIR)/mspmath/build_clang/libmspmath.a.bc

ALL_LIB_DIRS := $(sort $(dir $(wildcard $(LIB_DIR)/*/)))

.PHONY: all dirs

all: dirs $(BIN)

dirs:
	@mkdir -p $(CLANG_BLD_DIR)

$(BIN): libs coala $(OBJECTS)
	$(V) $(LLVM_LINK) -o $(BC) $(OBJECTS) $(LLVM_LIBS)
	$(V) $(LLVM_LLC) -O0 $(BC) -o $(ASM)
	$(V) $(GCC) $(LFLAGS) -o $@ $(ASM) $(LIBS)
	$(VECHO) "Built $(PROJECT).out"
	$(VECHO) ""

.PHONY: $(ALL_LIB_DIRS) libs coala

libs: $(ALL_LIB_DIRS)

# export the variables to the submake 
export
$(ALL_LIB_DIRS):
	@$(MAKE) -C $@ TOOLCHAIN=gcc
	@$(MAKE) -C $@ TOOLCHAIN=clang

coala:
	@$(MAKE) -C $(COALA_DIR) TOOLCHAIN=gcc
	@$(MAKE) -C $(COALA_DIR) TOOLCHAIN=clang

-include $(DEPS)

$(CLANG_BLD_DIR)/%.bc: $(SRC_DIR)/%.c
	$(V) $(LLVM_CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: clean rebuild run help

clean:
	@rm -rf $(CLANG_BLD_DIR)

clean-all:
	@rm -rf $(BLD_DIR)
	@rm -rf $(LIB_DIR)/*/build*
	@rm -rf $(COALA_DIR)/build*

rebuild: clean all

run: all
	$(V) mspdebug -q -v 3300 tilib "prog $(BIN)"

help:
	@echo "List of available targets:"
	@echo "- all      build libraries (including Coala) and application"
	@echo "- clean    clean build directory"
	@echo "- rebuild  clean and rebuild application"
	@echo "- run      run application using mspdebug"
