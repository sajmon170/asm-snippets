.686
.model flat

extern _ExitProcess@4: PROC
extern _malloc: PROC
extern _calloc: PROC

.code
; int strlen(char* str)
_nstrlen PROC
    push ebp
    mov ebp, esp

    push edi

    mov eax, 0
    mov edi, [ebp + 8]
    repne scasb
    mov eax, edi
    sub eax, [ebp + 8]
    dec eax

    pop edi

    mov esp, ebp
    pop ebp
    ret
_nstrlen ENDP

;void memcpy(void* dest, void* src, int size)
_nmemcpy PROC
    push ebp
    mov ebp, esp

    push ecx
    push esi
    push edi

    mov edi, [ebp + 8]
    mov esi, [ebp + 12]
    mov ecx, [ebp + 16]
    rep movsb

    pop edi
    pop esi
    pop ecx

    mov esp, ebp
    pop ebp
    ret
_nmemcpy ENDP

; void memswp(void* mem1, void* mem2, int stride)
_memswp PROC
    push ebp
    mov ebp, esp

    push ecx
    push ebx
    push esi
    push edi

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]
    mov ecx, [ebp + 16]
    et:
        mov bl, [esi]
        xchg bl, [edi]
        xchg [esi], bl

        inc esi
        inc edi
    loop et

    pop edi
    pop esi
    pop ebx
    pop ecx

    mov esp, ebp
    pop ebp
    ret
_memswp ENDP

; void sort(void* memory,
;           int size,
;           int stride,
;           int (*cmp)(void*, void*))
_sort PROC
    push ebp
    mov ebp, esp

    pusha

    mov esi, [ebp + 8]
    
    mov eax, [ebp + 12]
    mul DWORD PTR [ebp + 16]
    add eax, esi
    mov [ebp + 12], eax

    mov ebx, esi
    while1:
        cmp ebx, [ebp + 12]
        je end_while1
        
        mov ecx, ebx
        while2:
            cmp ecx, [ebp + 12]
            je end_while2

            
            push ebx
            push ecx
            call DWORD PTR [ebp + 20]
            add esp, 8
            if_swap:
                cmp eax, 0
                jng end_if

                mov eax, [ebp + 16]
                push eax
                push ebx
                push ecx
                call _memswp
                add esp, 12
            end_if:

            add ecx, DWORD PTR [ebp + 16]
            jmp while2
        end_while2:

        add ebx, DWORD PTR [ebp + 16]
        jmp while1
    end_while1:

    popa

    mov esp, ebp
    pop ebp
    ret
_sort ENDP

cmpr PROC
    push ebp
    mov ebp, esp

    push ebx
    push ecx

    mov ebx, [ebp + 8]
    mov ebx, [ebx]
    
    mov ecx, [ebp + 12]
    mov ecx, [ecx]

    xor eax, eax
    cmp ebx, ecx
    setg al

    pop ecx
    pop ebx

    mov esp, ebp
    pop ebp
    ret
cmpr ENDP

;sort_ints(int* array, int size)
_sort_ints PROC
    push ebp
    mov ebp, esp

    mov eax, OFFSET cmpr
    push eax
    push 4
    mov eax, [ebp + 12]
    push eax
    mov eax, [ebp + 8]
    push eax
    call _sort
    add esp, 16

    mov esp, ebp
    pop ebp
    ret
_sort_ints ENDP


; int count_matching(void* mem,
;                    int size,
;                    int stride,
;                    int (*cmp)(void*))
_count_matching PROC
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push esi

    mov ebx, 0
    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]

    et:
        push esi
        call DWORD PTR [ebp + 20]
        add esp, 4

        if_matching:
            cmp eax, 0
            jng end_if
            inc ebx
        end_if:
        
        add esi, [ebp + 16]
    loop et

    mov eax, ebx

    pop esi
    pop ecx
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_count_matching ENDP

; int filter(void* mem,
;            int size,
;            int stride,
;            int (*cmp)(void*)
;            void** dest)
; Zwracany element w dest należy zwolnić
; za pomocą _free
_filter PROC
    push ebp
    mov ebp, esp
    sub esp, 8

    push ecx
    push esi
    push edi

    mov eax, [ebp + 20]
    push eax
    mov eax, [ebp + 16]
    push eax
    mov eax, [ebp + 12]
    push eax
    mov eax, [ebp + 8]
    push eax
    call _count_matching
    add esp, 16

    mov [ebp - 4], eax

    mul DWORD PTR [ebp + 16]
    push eax
    call _malloc
    add esp, 4

    mov [ebp - 8], eax

    mov edi, eax
    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]

    et:
        push esi
        call DWORD PTR [ebp + 20]
        add esp, 4

        if_matching:
            cmp eax, 0
            jng end_if

            mov eax, [ebp + 16]
            push eax
            push esi
            push edi
            call _nmemcpy
            add esp, 12
            add edi, [ebp + 16]
        end_if:
        
        add esi, [ebp + 16] 
    loop et

    mov edi, [ebp - 8]
    mov eax, [ebp + 24]
    mov [eax], edi

    mov eax, [ebp - 4]

    pop edi
    pop esi
    pop ecx

    mov esp, ebp
    pop ebp
    ret
_filter ENDP

_filter_and_fill PROC
_filter_and_fill ENDP


; double avg(double* nums, int count)
_avg PROC
    push ebp
    mov ebp, esp

    push ecx
    push esi
    
    mov ecx, [ebp + 12]
    mov esi, [ebp + 8]

    finit
    fldz

    et:
        fld QWORD PTR [esi]
        fadd
        add esi, 8
    loop et

    fild WORD PTR [ebp + 12]
    fdiv

    mov esp, ebp
    pop ebp
    ret
_avg ENDP

;float_avg

END
