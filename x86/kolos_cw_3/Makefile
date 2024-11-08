SOURCES  := $(wildcard *.asm)
OBJECTS  := $(patsubst %.asm,%.o,$(SOURCES))
FLAGS    := -nologo -Zd -Zi -Zg -Zne -coff
LDFLAGS  := -ggdb3

.PHONY: all clean

all: program

clean:
	$(RM) $(OBJECTS) program.exe

program: $(OBJECTS)
	i686-w64-mingw32-gcc -g $^ -o $@ $(LDFLAGS)

%.o: %.asm
	uasm $(FLAGS) $<
