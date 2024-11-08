.section .data


.section .text

.globl _start
_start:
	movl $123, %edi
	pushl %edi
	movl (%esp), %ebx
	
	movl $1, %eax
	int $0x80
