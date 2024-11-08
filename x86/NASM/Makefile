CSOURCES  := $(wildcard *.c)
COBJECTS  := $(patsubst %.c,%.o,$(CSOURCES))
CDEPENDS  := $(patsubst %.c,%.d,$(CSOURCES))

ASMSOURCES  := $(wildcard *.asm)
ASMOBJECTS  := $(patsubst %.asm,%.o,$(ASMSOURCES))
ASMFLAGS    := -g dwarf2 -f elf

LDFLAGS := -m32 -no-pie -ggdb3 -lm

.PHONY: all clean

all: program

clean:
	$(RM) $(ASMOBJECTS) program

program: $(COBJECTS) $(ASMOBJECTS)
	gcc $^ -o $@ $(LDFLAGS)

-include $(CDEPENDS)

%.o: %.asm
	yasm $(ASMFLAGS) $<

%.o: %.c Makefile
	gcc -c $< -o $@ $(LDFLAGS)
