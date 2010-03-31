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
* [QNX][] 6
* 4.4 BSD Lite 2 (not generally used by production systems)
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

## Acknowledgments

* Benjamin Reed, *ranger /at/ befunk.com*, supplied the initial Makefile
  changes to build it on Mac OS X.
* Sven Fischer, *fischer /at/ deutaeit.de*, informed me that it works,
  without change, on QNX 6.
* John Gilmore, *gnu /at/ toad.com*, reported some linkage errors on Mac OS
  X, suggested the addition of the `nfds_t` type, and suggested a revision of
  the license.

## License and Copyright

This software copyright &copy; 1995—2010 Brian M. Clapper, and is released
under a BSD license. See the [license][] file for complete details.

[license]: license.html

## Author

Brian M. Clapper, [bmc /at/ clapper.org][]

[bmc /at/ clapper.org]: mailto:bmc@clapper.org
