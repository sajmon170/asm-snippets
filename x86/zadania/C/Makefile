SOURCES  := $(wildcard *.c)
OBJECTS  := $(patsubst %.c,%.o,$(SOURCES))
DEPENDS  := $(patsubst %.c,%.d,$(SOURCES))

LDFLAGS :=

.PHONY: all clean

all: program

clean:
	$(RM) $(DEPENDS) $(OBJECTS) program

program: $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

-include $(DEPENDS)

%.o: %.c Makefile
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@ $(LDFLAGS)
