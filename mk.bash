#!/bin/bash

set -e
set -x

export LANG=C

# make distclean

autoreconf -Wall -i

mkdir -p native w32

(
    cd native
    ../configure LDFLAGS='-static-libstdc++ -static-libgcc'
    # GNU libtool does not understand '-static-libstdc++ -static-libgcc' yet
    make LIBTOOL=slibtool

    # There must not contain libstdc++ or libgcc:
    ldd .libs/p
    ldd .libs/libp.so
)

(
    cd w32
    chost=i686-w64-mingw32
    ../configure --host=${chost} LDFLAGS='-static-libstdc++ -static-libgcc'
    # GNU libtool does not understand '-static-libstdc++ -static-libgcc' yet
    make LIBTOOL=slibtool

    # There must not contain libstdc++ or libgcc:
    ${chost}-objdump -x .libs/p.exe      | fgrep -i .dll
    ${chost}-objdump -x .libs/libp.dll.0 | fgrep -i .dll
)
