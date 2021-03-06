/* Act like a Linux kernel image.
 * Obviously, this isn't a bootloader, but it's in src/kernel/bootloader
 * because it performs the same functions any other 
 * bootloader interface would. */

.arm
.section .text
.org 0
.global init
/* Must be position-independent! */
init:
	cmp	r0, #0
	beq	$$r0_ok
$$r0_notok:
	bkpt
$$r0_ok:
.ifdef	machine_type_required
	ldr	r0, =machine_type
	cmp	r1, r0
	beq	$$machinetype_ok
$$machinetype_notok:
	bkpt
.endif
$$machinetype_ok:
	/* begin parsing ATAGs */
	/* get ATAG start address */
	mov	r4, r2
	
	ldr	r3, =0x54410000 /* handy offset */

	mov	r6, #0
$$atag_parse_loop:
	/* r6 is tag size, r7 is tag type */
	mov	r0, r6, lsl #2
	ldrd	r6, r7, [r4, r0]!
	
	/* get tag type */
	cmp	r7, #0 /* ATAG_NONE */
	beq	$$parse_atag_none 

	sub	r7, r7, r3 /* subtract 0x5441000 from the tag type */
	cmp	r7, #2 /* ATAG_MEM */
	beq	$$parse_atag_mem

	b	$$atag_parse_loop /* unrecognized tag */

$$parse_atag_none:
	/* ATAG_NONE ends the tag list */
	b	$$done_parsing_atags

$$parse_atag_mem:
	adr	r0, $$num_mem_regions
	ldr	r0, [r0]
	cmp	r0, #0
	beq	$$first_mem_region
	bkpt	/* we don't support more than 1 memory region ATM */
$$first_mem_region:
	ldrd	r0, r1, [r4, #8] /* r0=size of region, r1=start of region */
	adr	r2, $$memory_info
	strd	r0, r1, [r2]

	adr	r0, $$num_mem_regions
	ldr	r1, [r0]
	add	r1, #1
	str	r1, [r0]

	b	$$atag_parse_loop

$$num_mem_regions:
	.word	0

$$memory_info:
	.word	0 /* size of memory */
	.word	0 /* start address of memory */

$$done_parsing_atags:

	adr	r0, $$memory_info
	ldmia	r0, {r0, r1}
	b	setup_mmu
