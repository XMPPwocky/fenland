.global VIRTUAL_ADDRESS
VIRTUAL_ADDRESS	= 0x80008000

.arm
.section .text
.align 2
.global setup_mmu
/* Enables the MMU.
 * Must be position-independent!
 * r0 = size of RAM
 * r1 = physical address of start of RAM */
setup_mmu:
	bkpt
