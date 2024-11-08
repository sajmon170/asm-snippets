.686
.model flat

public ntobigbin
extern _calloc: PROC

.data

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

; int* ntobigbin(char* number, int base)
ntobigbin PROC
    push ebp
    mov ebp, esp

    NUM_SIZE = 2

    push NUM_SIZE * 4
    call _calloc
    add esp, 4
    mov ebx, eax                ; destination
    
    mov eax, 0                  ; current 32-bit cell
    mov esi, [ebp + 8]          ; source number 
    mov edi, NUM_SIZE - 1       ; destination index
    mov edx, 0                  ; carry

    while1:
        xor ecx, ecx
        mov cl, [esi]
        call decode_cl

        add eax, ecx
        add eax, edx

        cmp BYTE PTR [esi + 1], 0
        je end_while1           ; TODO: fix this

        mul DWORD PTR [ebp + 12]
        jc if_carry
        jmp end_if

        if_carry:
            mov [ebx + 4*edi], eax
            mov eax, 0
            dec edi
        end_if:
        
        inc esi
        jmp while1
    end_while1:

    mov [ebx + edi], eax
    mov eax, ebx
    
    mov esp, ebp
    pop ebp
    ret
ntobigbin ENDP
END
