# Source and build directories
PROJECT       := mspbuiltins
SRC_DIR       := src
BLD_DIR       := build
MAKER_DIR     := ../../maker

include $(MAKER_DIR)/envCom.mk

OBJECTS := $(BLD_DIR)/builtins.o
LIB     := lib$(PROJECT)
BIN     := $(BLD_DIR)/$(LIB).a

.PHONY: all dirs clean
	
all: dirs $(BIN)

dirs:
	@mkdir -p $(BLD_DIR)

$(BIN): $(OBJECTS)
	$(V) $(AR) rcs $@ $^
	$(VECHO) "Built $(LIB).a"
	$(VECHO) ""

$(BLD_DIR)/%.o: $(SRC_DIR)/%.S
	$(V) $(AS) -mmcu=$(DEVICE) $< -o $@

clean:
	@rm -rf $(BLD_DIR)
