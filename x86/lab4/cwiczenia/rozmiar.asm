.686
.model flat

public _rozmiar
extern _FindFirstFileW@8: PROC
extern _CloseHandle@4:    PROC

INVALID_HANDLE_VALUE = 02h

.code
; long long rozmiar(wchar_t* tablica)
_rozmiar PROC
    push ebp
    mov ebp, esp

    sub esp, 100

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    lea ebx, [ebp - 100]

    push ebx
    push eax
    call _FindFirstFileW@8

    if_invalid:
        cmp edx, INVALID_HANDLE_VALUE
        jne if_valid
        mov edx, -1
        mov eax, -1
        jmp end_if
    if_valid:
        mov edx, [ebp - 100 + 28]
        mov eax, [ebp - 100 + 32]
    end_if:

    push eax
    push edx
    lea ebx, [ebp - 100]
    push ebx
    call _CloseHandle@4
    pop edx
    pop eax

    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_rozmiar ENDP
END
