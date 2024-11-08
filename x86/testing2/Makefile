SOURCES  := $(wildcard *.asm)
OBJECTS  := $(patsubst %.asm,%.o,$(SOURCES))
FLAGS    := -nologo -Zd -Zg -Zne -coff
LDFLAGS  :=

.PHONY: all clean

all: program

clean:
	$(RM) $(OBJECTS) program.exe

program: $(OBJECTS)
	i686-w64-mingw32-gcc $^ -o $@ $(LDFLAGS)

%.o: %.asm
	uasm $(FLAGS) $<
