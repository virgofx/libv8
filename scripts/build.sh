#!/usr/bin/env bash

set -e

HOME_DIR=${PWD}
TEMP_DIR=/tmp
NUM_CPUS=$(grep -c ^processor /proc/cpuinfo)

if [ -z $V8_VERSION ]; then
    V8_VERSION=${1}
fi

if [ -z $V8_VERSION ]; then
    echo 'No V8_VERSION specifed. Specify an ENV variable or argument to define V8_VERSION' 1>&2
    exit 1
fi

cd ${TEMP_DIR}

# Note: depot_tools already installed in container in /depot_tools

echo "#########################################################################################"
echo "Fetching V8"
echo "#########################################################################################"
fetch v8

echo "#########################################################################################"
echo "Syncing V8 to version: ${V8_VERSION}"
echo "#########################################################################################"
cd v8
git checkout -b ${V8_VERSION}
gclient sync

echo "#########################################################################################"
echo "Initializing V8 GN ..."
echo "#########################################################################################"
tools/dev/v8gen.py -vv x64.release -- \
    is_component_build=true \
    is_debug=false \
    is_official_build=true \
    is_cfi=false \
    is_clang=false \
    treat_warnings_as_errors=false \
    use_allocator_shim=false \
    use_custom_libcxx=false \
    use_gold=false \
    use_sysroot=false \
    v8_use_external_startup_data=false

#last known working
tools/dev/v8gen.py -vv x64.release

tools/dev/v8gen.py -vv x64.release -- \
    is_component_build=true \
    is_debug=false \
    is_official_build=true

echo "#########################################################################################"
echo "Building ..."
echo "#########################################################################################"
ninja -j ${NUM_CPUS} -C out.gn/x64.release/

echo "#########################################################################################"
echo "Installing V8 binaries + build data into system ..."
echo "#########################################################################################"
mkdir -p /build/v8/{lib,include}
cp out.gn/x64.release/lib*.so out.gn/x64.release/*_blob.bin out.gn/x64.release/icudtl.dat /build/v8/lib/
cp -R include/* /build/v8/include/