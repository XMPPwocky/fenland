ENTRY(__uboot_init);
OUTPUT_FORMAT(elf32-littlearm);

virtual_addr = 0xB0000000;

SECTIONS
{
	. = virtual_addr;
	.stack : 
		{ *(.stack) }
	.text : 
		{ *(.text) }
	.data : 
		{*(.rodata) *(.data) }
	.bss : 
		{ *(.bss) }
}
