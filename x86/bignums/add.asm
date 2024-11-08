.686
.model flat

public addlong

extern transform: PROC
extern decode:    PROC
extern encode:    PROC
extern strlen:    PROC

extern _calloc: PROC

.code

; void swap(void32* a, void32* b)
swap PROC
    push ebp
    mov ebp, esp
    
    pusha

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    mov ecx, [eax]
    xchg ecx, [ebx]
    mov [eax], ecx

    popa

    mov esp, ebp
    pop ebp
    ret
swap ENDP

; char* add(char* a, char* b)
addlong PROC
    push ebp
    mov ebp, esp
    sub esp, 12

    push ebx
    push esi
    push edi

    mov eax, [ebp + 12]
    push eax
    call strlen
    add esp, 4
    mov ebx, eax
    mov [ebp - 8], ebx
    
    mov eax, [ebp + 8]
    push eax
    call strlen
    add esp, 4
    mov [ebp - 4], eax

    if_ebx_is_bigger:
        cmp eax, ebx
        jnle eax_is_bigger
        xchg eax, ebx
        mov [ebp - 8], ebx
        mov [ebp - 4], eax

        lea ecx, [ebp + 8]
        push ecx
        lea ecx, [ebp + 12]
        push ecx
        call swap
        add esp, 8
    eax_is_bigger:
    mov DWORD PTR [ebp - 12], 0
; [ebp + 8]  - bigger string
; [ebp - 4]  - strlen(bigger string)
; [ebp + 12] - shorter string
; [ebp - 8]  - strlen(shorter string)
; [ebp - 12] - final length

    mov eax, [ebp + 8]
    push OFFSET decode
    push eax
    call transform
    add esp, 8

    mov eax, [ebp + 12]
    push OFFSET decode
    push eax
    call transform
    add esp, 8

    mov esi, [ebp + 8]  ; bigger_str  iterator
    add esi, [ebp - 4]
    dec esi
    
    mov edi, [ebp + 12] ; smaller_str iterator
    add edi, [ebp - 8]
    dec edi

    xor ax, ax

    mov ecx, [ebp - 8]
    mov bl, 10
    while1:
        mov ax, 0
        add al, [esi]
        add al, [edi]
        add al, bh
        
        div bl
        movzx edx, ah
        push edx
        inc DWORD PTR [ebp - 12]
        mov bh, al

        dec esi
        dec edi
    loop while1

    mov ecx, [ebp - 4]
    sub ecx, [ebp - 8]
    cmp ecx, 0
    je finished_adding
    while2:
        mov ax, 0
        add al, [esi]
        add al, bh
        
        div bl
        movzx edx, ah
        push edx
        inc DWORD PTR [ebp - 12]
        mov bh, al

        dec esi
    loop while2

    finished_adding:

    cmp bh, 0
    je carry_included
        movzx edx, bh
        push edx
        inc DWORD PTR [ebp - 12]
    carry_included:

    inc DWORD PTR [ebp - 12]

    mov eax, [ebp - 12]
    push eax
    call _calloc
    add esp, 4

    mov edi, 0

    mov ecx, [ebp - 12]
    dec ecx
    while3:
        pop ebx
        add ebx, '0'
        mov [eax + edi], bl
        inc edi
    loop while3

    pop edi
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
addlong ENDP

END
