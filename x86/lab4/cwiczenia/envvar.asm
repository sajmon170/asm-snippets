.686
.model flat

public _envvar

extern _GetEnvironmentVariableW@12: PROC
extern _wprintf: PROC

ERROR_ENVVAR_NOT_FOUND = 0CBh

.code

; int envvar(wchar_t* name)
_envvar PROC
    push ebp
    mov ebp, esp
    sub esp, 1000

    push ebx
    push esi
    push edi

    push 500
    lea eax, [ebp - 1000]
    push eax
    mov eax, [ebp + 8]
    push eax
    call _GetEnvironmentVariableW@12

    if_not_found:
        cmp edx, ERROR_ENVVAR_NOT_FOUND
        jne if_found
        mov eax, -1
        jmp end_if
    if_found:
        push eax
        lea eax, [ebp - 1000]
        push eax
        call _wprintf
        add esp, 4
        pop eax
    end_if:

    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_envvar ENDP
END
