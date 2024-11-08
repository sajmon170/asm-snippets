.686
.model flat
public _main

printf PROTO C, fmt:vararg
scanf  PROTO C, fmt:vararg

extern _puts : PROC
extern _ExitProcess@4 : PROC
extern __write : PROC
extern _putchar : PROC

.data
str_fmt  db "%s", 0DH, 0AH, 0
string   db "This is an ASCII string", 0
reversed db $ - OFFSET string dup (?)
format   db '%d', 0DH, 0AH, 0
chars    db '%c', 0
debug    db "Debug", 0
numbers  db '1', '2', '3', '4', '5', '6'
num_size db $ - OFFSET numbers


.code

str_iter PROC                   ;arg1 = string
    push ebp
    mov ebp, esp

    mov edi, 0
    mov ebx, [ebp + 8]
    begin:
        xor eax, eax
        mov ax, [ebx + edi]
        cmp ax, 0
        je end_loop

        push ax
        call _putchar
        add esp, 1

        inc edi
        jmp begin
    end_loop:
    
    mov esp, ebp
    pop ebp
    ret
str_iter ENDP

sqr PROC
    push ebp
    mov ebp, esp

    
    
    mov esp, ebp
    pop ebp
    ret
sqr ENDP

map PROC                        ;arg1 = count, arg2 = array, arg3 = func
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov esi, 0
    begin:
    
    inc esi
    loop begin
    
    mov esp, ebp
    pop ebp
    ret
map ENDP

comment @ 
reverse PROC
    push ebp
    mov ebp, esp
    
    push OFFSET string
    call strlen
    add esp, 4
    
    dec eax
;   back_iter = last_char
    mov ebx, eax
;   front_iter = first_char
    mov ecx, 0
;   eax /= 2
    shr eax, 2

    begin:
        push eax
        push ebx

        push 
        
        pop ebx
        pop eax
    loop begin
    
    
    mov esp, ebp
    pop ebp
    ret
reverse ENDP
@

_main PROC
    push OFFSET string
    call str_iter
    add esp, 4

    invoke printf, OFFSET debug
    
    push 0
    call _ExitProcess@4
_main ENDP
END
