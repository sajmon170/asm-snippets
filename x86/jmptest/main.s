global _start

section .text
_start:
	mov rax, 10
	mov rbx, 20
	sub rax, rbx
	jle exit

	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, len
	syscall

exit:
	mov rax, 60
	mov rdi, 0
	syscall

section .rodata
	msg: db "Hello, world!", 0xA
	len: equ $ - msg
