#!/bin/sh

# This scripts runs all BLAS tests against the BLAS implementation currently
# selected through the alternatives system
# (see "update-alternatives --display libblas64.so.3-${DEB_HOST_MULTIARCH}").
# The BLAS implementation can be overriden using LD_LIBRARY_PATH.

# This script creates a few temporary files in the current directory.

DEB_HOST_MULTIARCH=$(dpkg-architecture -q DEB_HOST_MULTIARCH)

PATH=/usr/lib/${DEB_HOST_MULTIARCH}/blas64:$PATH

DATADIR=/usr/lib/${DEB_HOST_MULTIARCH}/blas64

# Test Fortran BLAS
for p in s d c z
do
    xblat1${p}
    xblat2${p} < $DATADIR/${p}blat2.in
    cat ${p}blat2.out
    xblat3${p} < $DATADIR/${p}blat3.in
    cat ${p}blat3.out
done

# Test CBLAS
for p in s d c z
do
    x${p}cblat1
    x${p}cblat2 < $DATADIR/${p}in2
    x${p}cblat3 < $DATADIR/${p}in3
done
