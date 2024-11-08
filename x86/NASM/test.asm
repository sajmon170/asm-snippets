global print_array
global gcd
extern printf
    
segment .data
    fmt db "%d ", 0
    end db 0Ah, 0

segment .text
; void print_array(const byte* array, int size)
print_array:
    push ebp
    mov ebp, esp

    push esi

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
.et:
    push ecx
    movsx eax, byte [esi]
    push eax
    push fmt
    call printf
    add esp, 8
    pop ecx
    inc esi
    loop .et

    push end
    call printf
    add esp, 4
    
    pop esi
    
    mov esp, ebp
    pop ebp
    
    ret

; int gcd(int i, int j)
gcd:
    push ebp
    mov ebp, esp
    
    mov esp, ebp
    pop ebp
    ret
    
