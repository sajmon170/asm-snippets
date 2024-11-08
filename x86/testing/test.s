.section .data
limit:
	.long 100
stop:
	.long 50

.section .text

.globl _start
_start:
	movl $0, %ebx
loop_fwd:
	incl %ebx
	cmpl %ebx, limit
	je loop_bwd
	jmp loop_fwd
loop_bwd:
	decl %ebx
	cmpl %ebx, stop
	je exit
	jmp loop_bwd

exit:
	movl $1, %eax
	int $0x80
