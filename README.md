GNU libtool does not handle -static-libgcc and -static-libstdc++ yet.
This makes it hard building shared libraries that don't have external
dependencies on gcc internals.

This tiny example uses slibtool to workaround GNU libtool limitation.