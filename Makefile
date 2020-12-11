SRCFILES := $(wildcard src/*.c lib/lua/*.c)
OBJFILES := $(SRCFILES:%.c=%.o)
LIBS ?= -lm
CFLAGS ?= -O3

gb: $(OBJFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

-include $(DEPFILES)

%.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf gb src/*.o lib/lua/*.o

.PHONY: clean test

