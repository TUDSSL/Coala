# Source and build directories
PROJECT       := dsp
SRC_DIR       := src
BLD_DIR       := build
CLANG_BLD_DIR := build_clang
MAKER_DIR     := ../../maker
LIB_DIR       := ..

include $(MAKER_DIR)/envCom.mk

# Fill in additional flags or includes
# (other than the ones defined in maker/libs.mk)

INCLUDES :=
CFLAGS :=

ifeq ($(TOOLCHAIN),clang)
include $(MAKER_DIR)/libs.clang.mk
else
include $(MAKER_DIR)/libs.mk
endif
