# Source and build directories
PROJECT       := ar
SRC_DIR       := ./
BLD_DIR       := build
CLANG_BLD_DIR := build_clang
MAKER_DIR     := ../../maker
LIB_DIR       := ../../libs

# Edit envCom.mk as needed
include $(MAKER_DIR)/envCom.mk

# Uncomment and edit if the path to msp430-gcc compiler is different
# than "/Developer/ti/msp430-gcc"
# GCC_DIR := /path/to/msp430-gcc

# Uncomment if additional flags, includes or libraries are needed
# (other than the ones defined in maker/apps.mk)
INCLUDES := \
	-I $(LIB_DIR)/mspmath/include \
	-I $(LIB_DIR)/wispbase/include \

# CFLAGS :=

LFLAGS := \
	-L $(LIB_DIR)/mspmath/build \
	-L $(LIB_DIR)/wispbase/build \

LIBS := \
	-lmspmath \
	-lwispbase \

LLVM_LIBS := \
	$(LIB_DIR)/wispbase/build_clang/libwispbase.a.bc \

ifeq ($(TOOLCHAIN),clang)
include $(MAKER_DIR)/apps.clang.mk
else
include $(MAKER_DIR)/apps.mk
endif
