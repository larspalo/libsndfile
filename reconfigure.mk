#!/usr/bin/make -f

ifneq ($(shell uname -s), Darwin)
  LIBTOOLIZE = libtoolize
else
  # Fuck Apple! Why the hell did they rename libtoolize????
  LIBTOOLIZE = glibtoolize
endif

config.status: configure
	./configure --enable-gcc-werror

configure: configure.ac aclocal.m4 Makefile.am src/config.h.in libtool ltmain.sh
	automake --copy --add-missing
	autoconf

src/config.h.in: configure.ac libtool
	autoheader

libtool ltmain.sh: aclocal.m4
	libtoolize --copy --force
	
# Need to re-run aclocal whenever acinclude.m4 is modified.
aclocal.m4: acinclude.m4
	aclocal

clean:
	rm -f libtool ltmain.sh aclocal.m4 Makefile.in src/config.h.in config.cache


# Do not edit or modify anything in this comment block.
# The arch-tag line is a file identity tag for the GNU Arch 
# revision control system.
#
# arch-tag: 2b02bfd0-d5ed-489b-a554-2bf36903cca9

