.686
.model flat
extern _ExitProcess@4   : PROC
extern _MessageBoxA@16  : PROC
extern _MessageBoxW@16  : PROC
public _main

.data
header  db 'Welcome', 0
content db 'Hello, world!', 0

; header_jp  dd 'よ','う','こ','そ', 0
; unicode_jp dd 'A','K','O','怖','す','ぎ','る', 0
header_jp	 dw 'Z', 'n', 'a', 'k', 'i', 0
unicode_jp	 dw 0D83DH, 0DC08H, 0

.code
_main PROC
      mov ecx, 85
      push 0
      push OFFSET header
      push OFFSET content
      push 0
      call _MessageBoxA@16
      add esp, 16

      push 0
      push OFFSET header_jp
      push OFFSET unicode_jp
      push 0
      call _MessageBoxW@16
      add esp, 16

      push dword PTR 0
      call _ExitProcess@4
_main ENDP
END
