ENTRY(__uboot_init);
OUTPUT_FORMAT(elf32-littlearm);

load_addr = 0x80008000;
virtual_addr = 0x80008000; /* Yay, RAM in the higher half! */

SECTIONS
{
	. = load_addr;

	.phys : AT(load_addr) { *(.phys) }

	. = virtual_addr + SIZEOF( .phys );
	. = ALIGN(1M); /* 1MB (section) aligned */

	.text : AT ( ADDR(.phys) + SIZEOF( .phys ) )
		{ *(.text) }
	.data : AT ( ADDR(.phys) + SIZEOF( .phys ) + SIZEOF( .text ) )
		{ *(.rodata) *(.data) }
	.bss : AT ( ADDR(.phys) + SIZEOF( .phys ) +
			SIZEOF( .text ) + SIZEOF( .data ) )
		{ *(.bss) }
}
