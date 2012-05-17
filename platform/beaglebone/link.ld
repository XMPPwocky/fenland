ENTRY(init);
OUTPUT_FORMAT(elf32-littlearm);

machine_type = 3808;

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
