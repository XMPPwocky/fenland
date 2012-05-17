.arm
.section .stack, "aw" 
.align 3
.global stack, stack_end
stack_end:
	.space 8192 /* probably oversized */
stack:
