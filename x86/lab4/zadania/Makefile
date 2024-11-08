CSOURCES  := $(wildcard *.c)
COBJECTS  := $(patsubst %.c,%.o,$(CSOURCES))
CDEPENDS  := $(patsubst %.c,%.d,$(CSOURCES))

ASMSOURCES  := $(wildcard *.asm)
ASMOBJECTS  := $(patsubst %.asm,%.o,$(ASMSOURCES))
ASMFLAGS    := -nologo -Zd -Zi -Zg -Zne -win64

LDFLAGS := -ggdb3 -lm

.PHONY: all clean

all: program

clean:
	$(RM) $(CDEPENDS) $(COBJECTS) $(ASMOBJECTS) program

program: $(COBJECTS) $(ASMOBJECTS)
	x86_64-w64-mingw32-gcc $^ -o $@ $(LDFLAGS)

-include $(CDEPENDS)

%.o: %.c Makefile
	x86_64-w64-mingw32-gcc -c $< -o $@ $(LDFLAGS)

%.o: %.asm
	uasm $(ASMFLAGS) $<
