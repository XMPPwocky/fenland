LINKERSCRIPT=$(PLATFORMDIR)/beaglebone/link.ld
ASFLAGS	+= -mcpu=cortex-a8 --defsym CFG_UBOOT=1

UBOOT_LOAD_ADDRESS = 0x80001000
UBOOT_ENTRY_ADDRESS = 0x80001000

include util/make_includes/uboot.mk
