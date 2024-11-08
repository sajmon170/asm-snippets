.section .data

items:
	.long 9049, 345, 234, 989, 2345, 23, 1233, 0

size:
	.long 8


.section .text

.globl _start
_start:
	movl $0, %edi
	movl items(, %edi, 4), %ebx

loop:
	incl %edi
	cmpl %edi, size
	je   end
	movl items(, %edi, 4), %eax
	cmpl %ebx, %eax
	jge loop
	movl %eax, %ebx
	jmp loop

end:
	movl $1, %eax
	int $0x80
