global main
	
segment .data
	num1 dd 2.3
	num2 dd 0.7

segment .bss
    outp: resd 1
	
segment .text
main:
	finit
	fld dword [num1]
	fld dword [num2]
	faddp
	fistp dword [outp]
	mov eax, [outp]
