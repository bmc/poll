# Makefile for poll(2) emulator
#
# $Id$
# ---------------------------------------------------------------------------

#############################################################################
# Definitions that you need to edit
#############################################################################

# ---------------------------------------------------------------------------
# Compilation and Linkage
#
# For GNU CC. Should work for FreeBSD, NetBSD, OpenBSD and BSD/OS

CC		= gcc
COMPILE_STATIC	= $(CC) -c 
COMPILE_SHARED	= $(CC) -c -fPIC 
LINK_SHARED	= $(CC) -shared
RANLIB		= ranlib

# ---------------------------------------------------------------------------
# Installation prefix

PREFIX		= /usr/local
LIBDIR		= $(PREFIX)/lib 
INCDIR		= $(PREFIX)/include

#############################################################################
# There should be no need to edit past this point
#############################################################################

.SUFFIXES: .po

.c.po:
	$(COMPILE_SHARED) $< -o $*.po
.c.o:
	$(COMPILE_STATIC) $<

SHLIB_NOVER	= libpoll.so 
SHLIB		= $(SHLIB_NOVER).1
LIB		= libpoll.a

all:		libs
libs:		$(SHLIB) $(LIB)
test:		polltest
install:
		mkdir -p $(LIBDIR)
		cp $(SHLIB) $(LIB) $(LIBDIR)
		cd $(LIBDIR) && ln -s $(SHLIB) $(SHLIB_NOVER)
		mkdir -p $(INCDIR)
		cp poll.h $(INCDIR)

clean:
		rm -f poll.po *.o libpoll.so* libpoll.a polltest

$(SHLIB):	poll.po
		$(LINK_SHARED) -o $(SHLIB) poll.po
$(LIB):		poll.o
		ar rv $(LIB) poll.o
polltest:	polltest.o
		$(CC) -o polltest polltest.o $(LIB)
