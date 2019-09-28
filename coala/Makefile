# Source and build directories
PROJECT       := coala
SRC_DIR       := src
BLD_DIR       := build
CLANG_BLD_DIR := build_clang
MAKER_DIR     := ../maker
LIB_DIR       := ../libs

include $(MAKER_DIR)/envCom.mk

# Uncomment if additional flags or includes are needed
# (other than the ones specified in maker/libs.mk)
INCLUDES := \
	-I $(LIB_DIR)/mspDebugger/include \
	-I $(LIB_DIR)/mspProfiler/include \
	-I $(LIB_DIR)/mspReseter/include \
	-I $(LIB_DIR)/mspprintf/include \
	-I $(LIB_DIR)/mspbase/include \

CFLAGS := -DENABLE_PARTIAL_COMMIT=0

ifeq ($(TOOLCHAIN),clang)
include $(MAKER_DIR)/libs.clang.mk
else
include $(MAKER_DIR)/libs.mk
endif
