ifndef _MAKEINCLUDE_UBOOT
_MAKEINCLUDE_UBOOT = 1

MKIMAGE	= mkimage


ifdef CFG_UBOOT
KERNELSOURCES += $(SRCDIR)/kernel/bootloader/uboot.s
endif

$(BUILDDIR)/kernel/kernel.itb : $(BUILDDIR)/kernel/kernel.bin
	$(MKIMAGE) -f $(FIT_IMAGE) $@
endif	
