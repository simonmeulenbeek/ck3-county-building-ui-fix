#!/bin/bash
BASE_FILE_VERSION=$1
PATCH_TARGET=$2
PATCHES_APPLIED=0
patches=()

function apply_patch {
    source $1
    export PRE
    export POST
    python patch.py $PATCH_TARGET
}

for patch in patches/*; do
    CURRENT_PATCH="${patch//patches\//}"
    apply_patch $patch
    PATCHES_APPLIED=$((PATCHES_APPLIED+1))
    patches+=("$CURRENT_PATCH")
done

echo "Finished applying ${PATCHES_APPLIED} patches"
echo "base file version: ${BASE_FILE_VERSION}"
echo "patches:"
for each in "${patches[@]}"
do
    echo "    $each"
done