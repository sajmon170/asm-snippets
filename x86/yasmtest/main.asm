extern printf
global main

section .data
string db "Hello, world!", 0Ah, 0

section .bss
array resd 10
   
section .text
fillarray:
    push ebp
    mov ebp, esp

    push ebx
    push esi

    mov esi, 0
    mov ebx, array

    .begin:
        cmp esi, 10
        je .end
        mov dword [ebx + 4*esi], esi

        inc esi
        jmp .begin
    .end:

    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret

printarray:
    push ebp
    mov ebp, esp
 
    push ebx
    push esi

    mov esi, 0
    mov ebx, array

    .begin:
        cmp esi, 10
        je .end
    
        mov eax, dword [ebx + 4*esi]
        push eax
        call printf
        add esp, 4

        inc esi
        jmp .begin
    .end:

    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
    
main:
    push string
    call printf
    add esp, 4

    call fillarray
    call printarray
    
    ret
