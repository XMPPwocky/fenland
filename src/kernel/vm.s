.arm
.section .data
.align 14
.global global_translation_tables
global_translation_tables:
	.rept 4096
	.word 0 /* default is faulting entry */
	.endr
