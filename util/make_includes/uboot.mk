ifndef _MAKEINCLUDE_UBOOT
_MAKEINCLUDE_UBOOT = 1

MKIMAGE	= mkimage

$(BUILDDIR)/kernel/kernel.itb : $(BUILDDIR)/kernel/kernel.bin
	$(MKIMAGE) -f $(FIT_IMAGE) $@
endif	
