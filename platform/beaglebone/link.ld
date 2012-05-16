ENTRY(__uboot_init);
OUTPUT_FORMAT(elf32-littlearm);

. = 0x80000000;
. += 0x00001000;
_stack = .;

SECTIONS
{
	.init : { *(.init) }
	.text : { *(.text) }
	.data : { *(.rodata) *(.data) }
	.bss : { *(.bss) }
}
