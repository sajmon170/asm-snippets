.686
.model flat

public ntobin

extern _printf: PROC

.data
debug db "uwu", 0

.code
; converts a char from ECX to an int
decode_cl PROC
    cmp cl, '9'
    jg if_text
    if_number:
        sub cl, '0'
        jmp end_if
    if_text:
        sub cl, 'A'
        add cl, 10
    end_if:
    
    ret
decode_cl ENDP

; int ntobin(char* number, int base)
ntobin PROC
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    mov eax, 0
    mov esi, 0
    mov edx, 0                  ; sign

    cmp [ebx], '-'
    je negative
    cmp [ebx], '+'
    je skip
    jmp end_cases
    
    negative:
        mov edx, 1
    skip:
        inc esi
    end_cases:
    push edx

    while1:
        xor ecx, ecx
        mov cl, [ebx + esi]
        call decode_cl

        add eax, ecx
        cmp BYTE PTR [ebx + esi + 1], 0
        je end_while1
        
        mul DWORD PTR [ebp + 12]
        inc esi
        jmp while1
    end_while1:

    pop edx
    cmp edx, 1
    jne exit
    fix_negative:
        mov edx, 0
        sub edx, eax
        mov eax, edx
    exit:
    
    mov esp, ebp
    pop ebp
    ret
ntobin ENDP
END
