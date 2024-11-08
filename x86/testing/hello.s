.section .data
string:
	.ascii "UwU\n\0"


.section .text

.globl _main
_start:
	jmp exit
	

exit:
	movl $1, %eax
	movl %eflags, %ebx
	int $0x80
