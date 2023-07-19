#!/bin/bash
set -x
# Make the script exit immediately if any command returns a non-zero exit status
# set -e

cp -f /root/nfp-drv-kmods-private-test/src/nfpcore/nfp_export.c /root/nfp-drv-kmods-private/src/nfpcore/nfp_export.c

cd /root/nfp-drv-kmods-private
make clean
make

cd /root/nfp-drv-kmods-private-test/
make test_prepare CONFIG_NFP=n KBUILD_EXTRA_SYMBOLS=/root/nfp-drv-kmods-private/src/Module.symvers

echo "reload driver and test harness as a check"

rmmod nfp
insmod /root/nfp-drv-kmods-private/src/nfp.ko
insmod /root/nfp-drv-kmods-private-test/src/nfp_test_harness.ko
