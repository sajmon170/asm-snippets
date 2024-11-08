.686
.model flat

public _quadratic

extern _ExitProcess@4: PROC
extern _printf: PROC

.data
four dq 4.0
two  dq 2.0
vara dq 3.56438349
varb dq 12.2344156
varc dq 1.34512314
fmt  db "x1: %f, x2: %f", 0Dh, 0Ah, 0

.code
_quadratic PROC
    push   ebp
    mov    ebp, esp

    mov    eax, [ebp + 8]

    finit
    fld    four
    fmul   QWORD PTR [ebp + 12]
    fmul   QWORD PTR [ebp + 28]  ; st(0) = 4ac

    fld    QWORD PTR [ebp + 20]
    fmul   st(0), st(0)          ; st(0) = b²

    fsub   st(0), st(1)
    fsqrt                        ; st(0) = sqrt(b² - 4ac)

    fld    QWORD PTR [ebp + 20]
    fchs
    fsub   st(0), st(1)          ; st(0) = -b - sqrt(Δ)

    fld    QWORD PTR [ebp + 12]
    fmul   two
    fdivp

    fst    QWORD PTR [eax]   
    fstp   st(0)

    fld    QWORD PTR [ebp + 20]
    fchs
    fadd   st(0), st(1)          ; st(0) = -b + sqrt(Δ)

    fld    QWORD PTR [ebp + 12]
    fmul   two
    fdivp

    fst    QWORD PTR [eax + 8]

    mov    esp, ebp
    pop    ebp
    ret
_quadratic ENDP

COMMENT !
_main PROC
    mov ebp, esp
    sub esp, 16
    
    mov eax, DWORD PTR [varc + 4]
    push eax
    mov eax, DWORD PTR [varc]
    push eax
    
    mov eax, DWORD PTR [varb + 4]
    push eax
    mov eax, DWORD PTR [varb]
    push eax
    
    mov eax, DWORD PTR [vara + 4]
    push eax
    mov eax, DWORD PTR [vara]
    push eax

    lea eax, [ebp - 16]
    push eax

    call _quadratic
    add esp, 28

    mov eax, [ebp - 16]
    push eax
    mov eax, [ebp - 12]
    push eax
    mov eax, [ebp - 8]
    push eax
    mov eax, [ebp - 4]
    push eax
    push OFFSET fmt
    call _printf
    add esp, 20

    push 0
    call _ExitProcess@4
_main ENDP
!
END
