section .data
	EXIT_SUCCESS equ  0
	SYS_EXIT     equ  60
	index        db   0


section .data
global _start
_start:
	mov al, 1
	mov [index], al
	mov rdi, [index]
exit:
	mov rax, SYS_EXIT
	; mov rdi, EXIT_SUCCESS
	syscall
