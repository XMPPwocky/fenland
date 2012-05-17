.arm
.section .text
.global __uboot_init
.org 0
__uboot_init:
	/* Calculate offset  */
	sub	r0, pc, #8 /* load address of __uboot_init */
	ldr	r1, =__uboot_init /* virtual address */
	subs	r4, r1, r0
	movlt	r5, #0 /* load address < virtual address */
	moveq	r5, #1 /* load address = virtual address, ideal case */
	movgt	r5, #2 /* load address > virtual address */

	bkpt
