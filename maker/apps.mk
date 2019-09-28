# Source and build files
SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%,$(BLD_DIR)/%,$(SOURCES:.c=.o))
DEPS    := $(OBJECTS:.o=.d)
BIN     := $(BLD_DIR)/$(PROJECT).out

MAKE    := make

# Build flags


# Possible control defines:
# ENABLE_PRF -> enable GPIO toggling for profiling
# AUTO_RST   -> enable timed MCU reset
# RST_TIME   -> base reset time (clock cycles)
# TSK_SIZ    -> enable profiling using built-in timer
# LOG_INFO   -> print debugging information
DEFINES += \
	-DENABLE_PRF=0 \
	-DAUTO_RST=0 \
	-DRST_TIME=25000 \
	-DTSK_SIZ=1 \
	-DLOG_INFO=0 \
	-DEXECUTION_TIME=0 \
	-DPAG_FAULT_CNTR=0
INCLUDES += \
	-I ./ \
	-I $(GCC_DIR)/include \
	-I $(LIB_DIR)/mspDebugger/include \
	-I $(LIB_DIR)/mspProfiler/include \
	-I $(LIB_DIR)/mspReseter/include \
	-I $(LIB_DIR)/mspprintf/include \
	-I $(LIB_DIR)/mspbase/include \
	-I $(LIB_DIR)/alpaca-gcc/include \
	-I $(COALA_DIR)/include

CFLAGS += \
	-mmcu=$(DEVICE) \
	-O1 \
	-g \
	-Wall \
	-MD \
	-std=c99 \
	$(DEFINES)

LFLAGS += \
	-Wl,-Map=$(BLD_DIR)/$(PROJECT).map \
	-T $(LSC_DIR)/$(DEVICE).ld \
	-L $(GCC_DIR)/include \
	-L $(LIB_DIR)/mspDebugger/build \
	-L $(LIB_DIR)/mspProfiler/build \
	-L $(LIB_DIR)/mspReseter/build \
	-L $(LIB_DIR)/mspprintf/build \
	-L $(LIB_DIR)/alpaca-gcc/build \
	-L $(COALA_DIR)/build

LIBS += \
	-lcoala \
	-lmspdebugger \
	-lmspprofiler \
	-lmspreseter \
	-lmspprintf \
	-lalpaca-gcc \
	-lgcc \
	-lc

ALL_LIB_DIRS := $(sort $(dir $(wildcard $(LIB_DIR)/*/)))

.PHONY: all dirs

all: dirs $(BIN)

dirs:
	@mkdir -p $(BLD_DIR)

$(BIN): libs coala $(OBJECTS)
	$(V) $(GCC) $(CFLAGS) $(LFLAGS) $(OBJECTS) $(LIBS) -o $@
	$(VECHO) "Built $(PROJECT).out"
	$(VECHO) ""

.PHONY: $(ALL_LIB_DIRS) libs coala

libs: $(ALL_LIB_DIRS)

# export the variables to the submake 
export
$(ALL_LIB_DIRS):
	@$(MAKE) -C $@

coala:
	@$(MAKE) -C $(COALA_DIR)

-include $(DEPS)

$(BLD_DIR)/%.o: $(SRC_DIR)/%.c
	$(V) $(GCC) $(CFLAGS) $(INCLUDES) -S $< -o $(@:.o=.asm)
	$(V) $(GCC) $(CFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: clean rebuild run help

clean:
	@rm -rf $(BLD_DIR)

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
