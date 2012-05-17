/* Act like a Linux kernel image. */

.arm
.section .text
.global init
.org 0
/* Must be position-independent! */
init:
	cmp	r0, #0
	beq	$$r0_ok
$$r0_notok:
	bkpt
$$r0_ok:
	ldr	r0, =machine_type
	cmp	r1, r0
	beq	$$machinetype_ok
$$machinetype_notok:
	bkpt
$$machinetype_ok:
	/* begin parsing ATAGs */
	/* get ATAG start address */
	mov	r4, r1
	
	ldr	r3, =0x5441000 /* handy offset */

	mov	r6, #0
$$atag_parse_loop:
	/* r6 is tag size, r7 is tag type */
	mov	r0, r6 /* used as non-overlapping index */
	ldrd	r6, r7, [r4, r0]!
	
	/* get tag type */
	cmp	r0, #0 /* ATAG_NONE */
	beq	$$parse_atag_none 

	sub	r0, r0, r3 /* subtract 0x5441000 from the tag type */
	cmp	r0, #2 /* ATAG_MEM */
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
	ldrd	r0, r1, [r4, #2] /* r0=size of region, r1=start of region */
	adr	r2, $$memory
	strd	r0, r1, [r2]

	adr	r0, $$num_mem_regions
	ldr	r1, [r0]
	add	r1, #1
	str	r1, [r0]

	b	$$atag_parse_loop

$$num_mem_regions:
	.word	0

$$memory:
	.word	0 /* size of memory */
	.word	0 /* start address of memory */

$$done_parsing_atags:
	bkpt
