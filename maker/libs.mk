# Source and build files
SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%,$(BLD_DIR)/%,$(SOURCES:.c=.o))
DEPS    := $(OBJECTS:.o=.d)
LIB     := lib$(PROJECT)
BIN     := $(BLD_DIR)/$(LIB).a


# Build flags

INCLUDES += \
	-I $(GCC_DIR)/include \
	-I ./include

CFLAGS += \
	-mmcu=$(DEVICE) \
	-O1 \
	-g \
	-Wall \
	-MD \
	$(INCLUDES)

.PHONY: all dirs clean

all: dirs $(BIN)

dirs:
	@mkdir -p $(BLD_DIR)

$(BIN): $(OBJECTS)
	$(V) $(AR) rcs $@ $^
	$(VECHO) "Built $(LIB).a"
	$(VECHO) ""

-include $(DEPS)

$(BLD_DIR)/%.o: $(SRC_DIR)/%.c
	$(V) $(GCC) $(CFLAGS) -S $< -o $(@:.o=.asm)
	$(V) $(GCC) $(CFLAGS) -c $< -o $@

clean:
	@rm -rf $(BLD_DIR)
