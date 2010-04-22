---
title: BSD poll(2) emulator
layout: withTOC
---

## Overview

This package implements the System V *poll*(2) system call for Unix-like
systems that do not support *poll*. For instance, the following Unix-like
operating systems do not support *poll*:

* [NetBSD][], prior to version 1.3
* [FreeBSD][], prior to version 3.0
* [OpenBSD][], prior to version 2.0
* [BSD/OS][]. (See the [BSD/OS man pages][].)
* Apple's [Mac OS X][] (prior to OS X 10.3)
* [QNX][] version 6
* 4\.4 BSD Lite 2 (not generally used by production systems)
* 386BSD (pretty much obsolete these days)

[NetBSD]: http://www.NetBSD.org/
[FreeBSD]: http://www.freebsd.org/
[OpenBSD]: http://www.openbsd.org/
[BSD/OS]: http://www.bsdi.com/
[BSD/OS man pages]: http://www.bsdi.com/bsdi-man
[Mac OS X]: http://www.apple.com/macosx/
[QNX]: http://www.qnx.com/

*poll* provides a method for multiplexing input and output on multiple open
file descriptors; in traditional BSD systems, that capability is provided
by *select*(2). While the semantics of *select* differ from those of
*poll*, *poll* can be readily emulated in terms of *select*, which is
exactly what this small piece of software does.

Brief documentation on this emulation can be found at the top of the
`poll.h` header file. For a full description of *poll*, consult W. Richard
Stevens' excellent book, *Unix Network Programming* (Prentice-Hall, 1990).
The software should compile on most BSD UNIX systems without modification.
I have successfully compiled it on:

* BSD/OS (BSDI) 1.1, 2.0, 2.1
* FreeBSD 2.1.0 through 4.11
* Mac OS X 10.4 (Tiger)

## Getting the software

The *poll* emulator is written in C. Given the number of Unix-like
operating systems, and the number of releases of each, it is impractical
for me to provide a *libpoll* binary for every combination of Unix-like
operating system and operating system release. So, currently, you must
build *poll* from source code, as described below.

There are two ways to get the source code:

* Download a release (zip file or tarball) from the [downloads page][].
* Clone a copy of the Git repository:

        $ git clone git://github.com/bmc/poll.git
        $ git clone http://github.com/bmc/pollfortune.git


[downloads page]: http://github.com/bmc/poll/downloads

## Building and installing the software

1. Edit the Makefile, adjusting any necessary definitions. Pay specific
   attention to the value of `PREFIX` and the compiler settings.
2. Type `make` to build the `libpoll.a` and `libpoll.so` libraries.
3. Type `make install` to install the shared and static libraries in
   `$(PREFIX)/lib` (default: `/usr/local/lib`) and the `poll.h` header file
   in `$(PREFIX)/include` (default: `/usr/local/include`)

## Using the poll emulator

### Compiling

To compile a program that wants the `poll.h` header file, you need to include
the appropriate "-I" option on the compiler command line. If you set `PREFIX`
to `/usr/local`, then use `-I/usr/local/include`. For instance:

    cc -c -I/usr/local/include mypollprog.c

### Linking

To link a program that uses *poll*, you need to link against the static or
shared version of the library you built and installed. Use the `-L` and
`-l` options:

    cc -o mypollprog mypollprog.o -L/usr/local/lib -lpoll

If you need to force static linkage, add `-static` (with *gcc*) to force use
of `libpoll.a`:

    cc -o mypollprog mypollprog.o -L/usr/local/lib -lpoll -static

### Possible Issues

#### Link errors on Mac OS X

John Gilmore encountered a linking problem on Mac OS X 10.5 (Leopard). Note
that I have not seen this problem on my 10.4 (Tiger) Mac:

> We couldn't merely compile our code and link it with `poll.c` and have
> it work; we got a conflict with the system library:
>
        /usr/bin/ld: warning multiple definitions of symbol _poll
        /var/tmp//ccSgmsaN.o definition of _poll in section (__TEXT,__text)
        /usr/lib/gcc/powerpc-apple-darwin8/4.0.0/../../../libSystem.dylib(poll.So) definition of _poll

> Instead we added `-Dpoll=myfakepoll` when compiling routines that call
> `poll()`, and when compiling `poll.c` itself, so there'd be no name
> conflict.

If you encounter this problem:

1. Uncomment the `POLL_RENAME` definition in the Makefile, rebuild the
   poll emulator library, and reinstall it.
2. Be sure to add `-Dpoll=pollemu` to the C compilation command line for
   any program you write that uses the poll emulator.

## Acknowledgments

* Benjamin Reed, *ranger /at/ befunk.com*, supplied the initial Makefile
  changes to build it on Mac OS X.
* Sven Fischer, *fischer /at/ deutaeit.de*, informed me that it works,
  without change, on QNX 6.
* John Gilmore, *gnu /at/ toad.com*, reported some linkage errors on Mac OS
  X, suggested the addition of the `nfds_t` type, and suggested a revision of
  the license.

## License and Copyright

This software is copyright &copy; 1995—2010 Brian M. Clapper, and is released
under a BSD license. See the [license][] file for complete details.

[license]: license.html

## Author

[Brian M. Clapper][]

## Patches

I gladly accept patches from their original authors. Feel free to email
patches to me or to fork the [GitHub repository][] and send me a pull
request. Along with any patch you send:

* Please state that the patch is your original work.
* Please indicate that you license the work to the *Poll Emulator*
  project under a [BSD License][license].

[GitHub repository]: http://github.com/bmc/poll
[Brian M. Clapper]: mailto:bmc@clapper.org
