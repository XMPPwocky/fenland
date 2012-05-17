LINKERSCRIPT=$(PLATFORMDIR)/beaglebone/link.ld
ASFLAGS	+= -mcpu=cortex-a8 --defsym CFG_UBOOT=1

FIT_IMAGE	= $(PLATFORMDIR)/beaglebone/fit_image.its
include util/make_includes/uboot.mk
