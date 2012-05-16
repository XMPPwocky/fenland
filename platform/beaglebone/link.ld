ENTRY(__uboot_init);
OUTPUT_FORMAT(elf32-littlearm);

. = 0x80000000; /* Load address */
. = 0x80001000;
_stack = .; /* this is the start of the stack, remember it grows downwards */

