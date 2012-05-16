LINKERSCRIPT=$(PLATFORMDIR)/beaglebone/link.ld
ASFLAGS	+= -mcpu=cortex-a8 --defsym CFG_UBOOT=1

UBOOT_LOAD_ADDRESS = 0x80001000
UBOOT_ENTRY_ADDRESS = $(shell $(NM) build/kernel/kernel.elf | \
		grep "__uboot_init" | sed -e "s/ [a-Z] __uboot_init//g")
# Mmm, unix.

include util/make_includes/uboot.mk
