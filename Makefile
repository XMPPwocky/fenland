# Local configuration
-include Makefile.local

# Directories
SRCDIR		= src
INCLUDEDIR	= include
BUILDDIR	= build

# Standard shell commands
RM	= rm
MKDIR	= mkdir

# Toolchain
ifdef CROSS_COMPILE
AR	= $(CROSS_COMPILE)ar
AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
else
$(warning CROSS_COMPILE not set, using default toolchain... Consider \
	setting CROSS_COMPILE in Makefile.local.)
endif

.PHONY:	kernel
kernel:	$(BUILDDIR)/kernel/kernel.a

# Autocreate BUILDDIR directory tree as needed
$(BUILDDIR)/%/ : 
	$(MKDIR) -p $@

# Cleaning up is simply removing the contents of BUILDDIR
.PHONY:	clean
clean	:
	$(RM) -rf $(BUILDDIR)/*

$(BUILDDIR)/kernel/kernel.a	:	$(KERNELOBJECTS) | $(BUILDDIR)/kernel/
	$(AR) -rcs $@ $^

$(BUILDDIR)/kernel/%.o	:	$(SRCDIR)/kernel/%.s | $(BUILDDIR)/kernel/
	$(AS) $(ASFLAGS) -o $@ $<
