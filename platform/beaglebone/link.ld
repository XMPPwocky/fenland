ENTRY(init);
OUTPUT_FORMAT(elf32-littlearm);

SECTIONS
{
	. = VIRTUAL_ADDRESS;
	.text : 
		{ *(.text) }
	.data : 
		{*(.rodata) *(.data) }
	.bss : 
		{ *(.bss) }
}
