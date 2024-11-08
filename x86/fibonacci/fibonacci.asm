.686
.model flat
public _main
extern _printf : PROC

.data
output db "%d", 0dh, 0ah, 0

.code
fib PROC
    push ebp
    mov  ebp, esp
    sub  esp, 4

    begin_if:
        cmp DWORD PTR [ebp + 8], 0
        jne @F
        mov eax, 1

    @@:
        cmp DWORD PTR [ebp + 8], 1
        jne @F
        mov eax, 1
    @@:
        dec DWORD PTR [ebp + 8]
        push DWORD PTR [ebp + 8]
        call fib
        add esp, 4
        mov DWORD PTR [ebp - 4], eax

        
        dec DWORD PTR [ebp + 8]
        push DWORD PTR [ebp + 8]
        call fib
        add esp, 4

        add eax, DWORD PTR [ebp - 4] 
    end_if:

    mov esp, ebp
    pop ebp
    ret
fib ENDP

_main PROC
      push 1
      call fib
      add esp, 5

      push eax
      push OFFSET output
      call _printf
      add esp, 8
_main ENDP
END
