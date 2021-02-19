#!/bin/bash
imgfile=$1
sysroot=$2
if [ "$EUID" -ne 0 ]
then
    echo "Please run $0 with sudo"
    exit -1
fi

loop_dev=$(losetup --find --show -P $imgfile)

cleanup() {
    umount img >/dev/null || true
    rm -r img >/dev/null || true
    losetup -d $loop_dev || true
}
if [ "$?" -ne 0 ]; then
    cleanup
    echo "Error while running 'losetup'"
    exit -2
fi
mkdir -p img
mount `echo $loop_dev`p1 img
cp -r $sysroot/* -t img/
sync
cleanup
exit 0