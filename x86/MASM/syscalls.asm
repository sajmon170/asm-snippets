.686
.model flat
extern _ExitProcess@4   : PROC
extern _MessageBoxA@16  : PROC
extern _MessageBoxW@16  : PROC
public _main

.data
header  db 'Welcome', 0
content db 'Hello, world!', 0
unicode_jp db '僕はコンピュータ アーキテクチャに合格しません。', 0

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
      push OFFSET 0
      push OFFSET unicode_jp
      push 0
      call _MessageBoxW@16
      add esp, 16

      push dword PTR 0
      call _ExitProcess@4
_main ENDP
END
