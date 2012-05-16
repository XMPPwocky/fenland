ifndef _MAKEINCLUDE_UBOOT
_MAKEINCLUDE_UBOOT = 1

MKIMAGE	= mkimage

$(BUILDDIR)/kernel/uImage : $(BUILDDIR)/kernel/kernel.bin
	$(MKIMAGE)	-A arm -O linux -T kernel -C none \
		-a $(UBOOT_LOAD_ADDRESS) -e $(UBOOT_ENTRY_ADDRESS) \
		-n "Fenland $(VERSION)" -d $< $@
endif	
