.686
.model flat

public _isPalindrome

.code

_isPalindrome PROC
    push ebp
    mov ebp, esp

    sub esp, 8

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]          ; string
    mov [ebp - 4], ebx

    mov ebx, [ebp + 12]
    mov [ebp - 8], ebx          ; length

    if_zero:
        cmp DWORD PTR [ebp - 8], 0
        jne if_one
        mov eax, 1
        jmp exit
    if_one:
        cmp DWORD PTR [ebp - 8], 1
        jne if_not_equal
        mov eax, 1
        jmp exit
    if_not_equal:
        mov ebx, [ebp - 4]
        mov esi, [ebp - 8]
        dec esi
        
        mov dl, [ebx + esi]
        mov dh, [ebx]
        cmp dl, dh
        je if_equal
        mov eax, 0
        jmp exit
    if_equal:
        mov ebx, [ebp - 8]
        sub ebx, 2
        push ebx
        
        mov ebx, [ebp - 4]
        inc ebx
        push ebx

        call _isPalindrome
        add esp, 8
exit:
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
_isPalindrome ENDP
END
