# Source and build directories
PROJECT       := rsa
SRC_DIR       := ./
BLD_DIR       := build
CLANG_BLD_DIR := build_clang
MAKER_DIR     := ../../maker
LIB_DIR       := ../../libs

# Edit env.mk as needed
include $(MAKER_DIR)/envCom.mk

# Uncomment and edit if the path to msp430-gcc compiler is different
# than "/Developer/ti/msp430-gcc"
# GCC_DIR := /path/to/msp430-gcc

# Uncomment if additional flags, includes or libraries are needed
# (other than the ones defined in maker/apps.mk)

INCLUDES := \
	-I $(GCC_DIR)/msp430-elf/include \

# CFLAGS :=
# LFLAGS :=

LIBS := \
	-lm \

include $(MAKER_DIR)/apps.mk
