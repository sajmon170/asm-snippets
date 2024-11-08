.686
.model flat
public _main
printf proto C :vararg

.data
format db "%d %d", 0dh, 0ah, 0
num1 dd 1
num2 dd 2

.code
_main PROC
invoke printf, OFFSET format, num1, num2 
_main ENDP
END
