.ifdef CFG_UBOOT
	.include "src/kernel/bootloader/uboot.s"
.else
	.error "No bootloader specified!"
.endif
