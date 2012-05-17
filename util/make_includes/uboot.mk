ifndef _MAKEINCLUDE_UBOOT
_MAKEINCLUDE_UBOOT = 1

ifndef MKIMAGE
MKIMAGE	= mkimage
endif

KERNELSOURCES += $(SRCDIR)/kernel/bootloader/linux.s

.PHONY: uImage
uImage: $(BUILDDIR)/uImage

$(BUILDDIR)/uImage : $(BUILDDIR)/kernel/kernel.bin
	$(MKIMAGE) -f $(FIT_IMAGE) $@

endif	
