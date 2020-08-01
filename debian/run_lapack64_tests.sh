#!/bin/sh

# This scripts runs all LAPACK tests against the BLAS and LAPACK implementations
# currently selected through the alternatives system
# (see "update-alternatives --display libblas64.so.3-${DEB_HOST_MULTIARCH}" and
#  "update-alternatives --display liblapack64.so.3-${DEB_HOST_MULTIARCH}").
# The BLAS and LAPACK implementations can be overriden using LD_LIBRARY_PATH.

# This script creates temporary files in the current directory.

DEB_HOST_MULTIARCH=$(dpkg-architecture -q DEB_HOST_MULTIARCH)

for testfile in /usr/lib/${DEB_HOST_MULTIARCH}/lapack64/x* /usr/lib/${DEB_HOST_MULTIARCH}/lapack64/*.in
do
    ln -s ${testfile}
done

/usr/lib/${DEB_HOST_MULTIARCH}/lapack64/lapack_testing.py -d . -r
