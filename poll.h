/*---------------------------------------------------------------------------*\
  $Id$

  NAME

	poll - select(2)-based poll() emulation function for BSD systems.

  SYNOPSIS
	#include "poll.h"

	struct pollfd
	{
	    int     fd;
	    short   events;
	    short   revents;
	}

	int poll (struct pollfd *pArray, unsigned long n_fds, int timeout)

  DESCRIPTION

	This file, and the accompanying "poll.c", implement the System V
	poll(2) system call for BSD systems (which typically do not provide
	poll()).  Poll() provides a method for multiplexing input and output
	on multiple open file descriptors; in traditional BSD systems, that
	capability is provided by select().  While the semantics of select()
	differ from those of poll(), poll() can be readily emulated in terms
	of select() -- which is how this function is implemented.

  AUTHOR
	Brian M. Clapper
	Wills Creek Software, Inc.
	bmc@WillsCreek.COM

  REFERENCES
	Stevens, W. Richard. Unix Network Programming.  Prentice-Hall, 1990.

  NOTES
	1. This software requires an ANSI C compiler.
\*---------------------------------------------------------------------------*/

#ifndef _POLL_EMUL_H_
#define _POLL_EMUL_H_

#define POLLIN		0x01
#define POLLPRI		0x02
#define POLLOUT		0x04
#define POLLERR		0x08
#define POLLHUP		0x10
#define POLLNVAL	0x20

struct pollfd
{
    int     fd;
    short   events;
    short   revents;
};

#ifdef __cplusplus
extern "C"
{
#endif

#if (__STDC__ > 0) || defined(__cplusplus)
extern int poll (struct pollfd *pArray, unsigned long n_fds, int timeout);
#else
extern int poll();
#endif

#ifdef __cplusplus
}
#endif

#endif /* _POLL_EMUL_H_ */
