# gambit - c/lua chess game
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = gambit.c
OBJ = $(SRC:.c=.o)

all: gambit

options:
	@echo gambit build options:
	@echo "CFLAGS  = $(GBCFLAGS)"
	@echo "LDFLAGS = $(GBLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

gambit.o: config.h gambit.h
x.o: arg.h config.h gambit.h

$(OBJ): config.h config.mk

gambit: $(OBJ)
	$(CC) -o $@ $(OBJ) $(GBLDFLAGS)

clean:
	rm -f gambit $(OBJ) gambit-$(VERSION).tar.gz

dist: clean
	mkdir -p gambit-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h gambit.info gambit.1 gambit.h $(SRC)\
		gambit-$(VERSION)
	tar -cf - gambit-$(VERSION) | gzip > gambit-$(VERSION).tar.gz
	rm -rf gambit-$(VERSION)

.PHONY: all clean dist 
