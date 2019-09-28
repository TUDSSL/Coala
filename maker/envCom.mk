# ########################## #
# Environment variables      #
# ########################## #

# Paths to toolchain
USER_MACH := $(shell whoami)
ifeq ($(USER_MACH),amjad)
GCC_DIR   := ~/ti/gcc
LLVM_DIR  := /opt/llvm-install/bin
else
GCC_DIR   := /Developer/ti/msp430-gcc
LLVM_DIR  := /Developer/llvm-3.8.1/llvm-install/bin
endif

# Path to Coala (used from apps/*/)
COALA_DIR := ../../coala

# TODO: would it be better to have
#
# COALA_DIR := /absolute/path/to/coala
# LIB_DIR   := /absolute/path/to/libs
#
# and remove LIB_DIR from each Makefile?

# Path to modified linker script
LSC_DIR   := $(COALA_DIR)/linkerScripts/8KB_pages

# ########################## #
# Common variables           #
# ########################## #

# GCC compiler and tools
GCC_MSP   := $(GCC_DIR)/bin/msp430-elf-
GCC       := $(GCC_MSP)gcc
AR        := $(GCC_MSP)ar
AS        := $(GCC_MSP)as

# LLVM compiler and tools
LLVM_CC   := $(LLVM_DIR)/clang
LLVM_LINK := $(LLVM_DIR)/llvm-link
LLVM_LLC  := $(LLVM_DIR)/llc

# Common constants
DEVICE    := msp430fr5969
DEVICE_UC := MSP430FR5969

# control showing the debugging info
VERBOSE ?= 1
ifeq ($(VERBOSE),1)
V :=
VECHO := @echo
else
V := @
VECHO := @true
endif


