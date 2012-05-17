VERSION		= 0.001

SRCDIR		= src
INCLUDEDIR	= include
BUILDDIR	= build
PLATFORMDIR	= platform

.PHONY:	kernel
kernel:	$(BUILDDIR)/kernel/kernel.elf

# Local configuration
-include Makefile.local

# Platform-specific configuration
ifdef PLATFORM
include $(PLATFORMDIR)/$(PLATFORM)/Makefile
else
$(error PLATFORM not set)
endif

# Standard shell commands
RM	= rm
MKDIR	= mkdir
TOUCH	= touch

# Toolchain
ifeq ($(origin _TOOLCHAIN),file)
# Already defined in either Makefile.local or platform Makefile
else
ifdef CROSS_COMPILE
AR	= $(CROSS_COMPILE)ar
AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
OBJCOPY	= $(CROSS_COMPILE)objcopy
NM	= $(CROSS_COMPILE)nm

_TOOLCHAIN = 1
else
$(error No toolchain configured! Set CROSS_COMPILE)
endif
endif

ifdef DEBUG
ASFLAGS += -g
LDFLAGS += -g
endif

LDFLAGS += -T $(LINKERSCRIPT)

KERNELSOURCES	+= $(wildcard $(SRCDIR)/kernel/*.s)
KERNELOBJECTS	= $(patsubst $(SRCDIR)/%.s,$(BUILDDIR)/%.o,$(KERNELSOURCES))

# Autocreate BUILDDIR directory tree as needed
.PRECIOUS: $(BUILDDIR)/%/.dir
$(BUILDDIR)/%/.dir : 
	@$(MKDIR) -p $(dir $@)
	@$(TOUCH) $@

# Cleaning up is simply removing the contents of BUILDDIR
.PHONY:	clean
clean	:
	$(RM) -rf $(BUILDDIR)/*

.SECONDEXPANSION:

$(BUILDDIR)/kernel/kernel.elf :	$(KERNELOBJECTS) | $$(dir $$@).dir
	$(LD) $(LDFLAGS) -T $(LINKERSCRIPT) -o $@ $^

$(BUILDDIR)/kernel/kernel.bin : $(BUILDDIR)/kernel/kernel.elf | $$(dir $$@).dir
	$(OBJCOPY) -O binary $< $@

$(BUILDDIR)/kernel/%.o :	$(SRCDIR)/kernel/%.s | $$(dir $$@).dir
	$(AS) $(ASFLAGS) -o $@ $<
