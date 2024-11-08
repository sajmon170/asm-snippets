CSOURCES  := $(wildcard *.c)
COBJECTS  := $(patsubst %.c,%.o,$(CSOURCES))
CDEPENDS  := $(patsubst %.c,%.d,$(CSOURCES))

ASMSOURCES  := $(wildcard *.asm)
ASMOBJECTS  := $(patsubst %.asm,%.o,$(ASMSOURCES))
ASMFLAGS    := -nologo -Zd -Zi -Zg -Zne -coff

LDFLAGS := -ggdb3 -lm -Wpsabi

.PHONY: all clean

all: program

clean:
	$(RM) $(CDEPENDS) $(COBJECTS) $(ASMOBJECTS) program

program: $(COBJECTS) $(ASMOBJECTS)
	i686-w64-mingw32-gcc $^ -o $@ $(LDFLAGS)

-include $(CDEPENDS)

%.o: %.c Makefile
	i686-w64-mingw32-gcc -c $< -o $@ $(LDFLAGS)

%.o: %.asm
	uasm $(ASMFLAGS) $<
