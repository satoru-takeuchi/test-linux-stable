#!/bin/bash

VERSION=$(uname -r)
[[ "$VERSION" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+) ]]
X_VERSION=${BASH_REMATCH[1]}
Y_VERSION=${BASH_REMATCH[2]}
Z_VERSION=${BASH_REMATCH[3]}

if [ ${X_VERSION} -ge 3 -a ${Y_VERSION} -ge 4 ] ; then
    make -C selftests run_tests
else
    echo "this test is supported 3.4 or later" >&2
    exit 1
fi
