.section .data


.section .text
.globl _start
_start:
	movl $0, %ebx

weird:
	movl _start, %ebx

exit:
	movl $1, %eax
	int $0x80
