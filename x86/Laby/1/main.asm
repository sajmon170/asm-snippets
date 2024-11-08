.686
.model flat

public _main

extern _printf         : PROC
extern _scanf          : PROC
extern _putchar        : PROC
extern __read          : PROC
extern _ExitProcess@4  : PROC
extern _MessageBoxW@16 : PROC
extern _SetConsoleCP@4
extern _SetConsoleOutputCP@4

;extern strlen          : PROC


.data
string db 32 dup(0)
header dw 'A', 'K', 'O', 0
num    dw 0
frog   dw 0D83DH, 0DC38H, 0
debug  db "DEBUG", 0
;kodowanie na Latin2

.code
;arg 1 = string
count PROC
    push ebp
    mov ebp, esp
    sub esp, 4                  ;max word found

    mov eax, 0                  ;current character count
    mov ebx, 0                  ;max character found
    mov ecx, 0                  ;word count
    mov edi, 0                  ;index
    mov esi, [ebp + 8]          ;address of input string

    mov dl,  0                  ;current character

    begin:
        xor edx, edx
        mov dl, [esi + edi]
        cmp dl, ' '
        je whitespace
        cmp dl, 0
        je end_loop

        cmp dl, 165
        je found
        cmp dl, 164
        je found
        cmp dl, 134
        je found
        cmp dl, 143
        je found
        cmp dl, 169
        je found
        cmp dl, 168
        je found
        cmp dl, 136
        je found
        cmp dl, 157
        je found
        cmp dl, 228
        je found
        cmp dl, 227
        je found
        cmp dl, 162
        je found
        cmp dl, 224
        je found
        cmp dl, 152
        je found
        cmp dl, 151
        je found
        cmp dl, 171
        je found
        cmp dl, 141
        je found
        cmp dl, 190
        je found
        cmp dl, 189
        je found

        jmp increment
    found:
    push OFFSET debug
    call _printf
    add esp, 4
        inc eax
        jmp increment
    whitespace:
        cmp eax, ebx
        jng @F
        mov ebx, eax
        mov [ebp - 4], ecx
    @@:
        mov eax, 0
        inc ecx 
    increment:
        inc edi
        jmp begin
    end_loop:

    xor ax, ax
    mov ax, [ebp - 4]
    add ax, '0'
    mov num, ax
    
    mov esp, ebp
    pop ebp
    ret
count ENDP

_main PROC
push 852
call _SetConsoleCP@4
push 852
call _SetConsoleCP@4

    push 32
    push OFFSET string
    push 0
    call __read
    add esp, 12

    push OFFSET string
    call count
    add esp, 4

    push OFFSET header
    push OFFSET num
    push 0
    call _MessageBoxW@16

    push 0
    call _ExitProcess@4
_main ENDP

END
