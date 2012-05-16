# Directories
SRCDIR		= src
INCLUDEDIR	= include
BUILDDIR	= build
PLATFORMDIR	= platform

# Local configuration
-include Makefile.local

# Platform-specific configuration
include $(PLATFORMDIR)/$(PLATFORM)/Makefile

# Standard shell commands
RM	= rm
MKDIR	= mkdir

# Toolchain
ifeq ($(origin AS),file)
# Already defined in either Makefile.local or platform Makefile
else
ifdef CROSS_COMPILE
AR	= $(CROSS_COMPILE)ar
AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
else
$(error No toolchain configured! Set CROSS_COMPILE?)
endif
endif

ifdef DEBUG
ASFLAGS += -g
LDFLAGS += -g
endif

LDFLAGS += -T $(LINKERSCRIPT)

KERNELSOURCES	= $(wildcard $(SRCDIR)/kernel/*.s)
KERNELOBJECTS	= $(patsubst $(SRCDIR)/%.s,$(BUILDDIR)/%.o,$(KERNELSOURCES))

.PHONY:	kernel
kernel:	$(BUILDDIR)/kernel/kernel.elf

# Autocreate BUILDDIR directory tree as needed
.PRECIOUS: $(BUILDDIR)/%/
$(BUILDDIR)/%/ : 
	$(MKDIR) -p $(dir $@)

# Cleaning up is simply removing the contents of BUILDDIR
.PHONY:	clean
clean	:
	$(RM) -rf $(BUILDDIR)/*

.SECONDEXPANSION:

$(BUILDDIR)/kernel/kernel.elf	:	$(KERNELOBJECTS) | $$(dir $$@)
	$(LD) $(LDFLAGS) -T $(LINKERSCRIPT) -o $@ $<

$(BUILDDIR)/kernel/%.o	:	$(SRCDIR)/kernel/%.s | $$(dir $$@)
	$(AS) $(ASFLAGS) -o $@ $<
