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
	/* save arguments */
	mov	r4, r0
	mov	r5, r1

	/* Determine offset from where we were loaded to our virtual address */
address_anchor:
	ldr	r0, =address_anchor	/* Virtual address of address_anchor */
	adr	r1, address_anchor	/* Physical address of address_anchor */
	subs	r6, r0, r1 /* offset */

	beq	$$no_relocation /* VA = PA */
	bkpt
$$no_relocation:

	/* Okay, now: do we have more than 2GB of RAM?
	 * If so, we can't map it all into the higher half. */

	cmp	r0, #0x80000000
	beq	$$can_map_all_ram
	bkpt
$$can_map_all_ram:
	bkpt
