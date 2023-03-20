#!/bin/bash

# $1 input is interim BSP version

# install BSP version
apt-get install -y /mnt/cloud/binaries/nfp-bsp/interim/deb/nfp-bsp*$1 --allow-downgrades

# ensure interfaces are visible by reloading the driver
rmmod nfp
insmod /root/nfp-drv-kmods-private/src/nfp.ko nfp_dev_cpp=1
sleep 2
ip link

# if ip link shows an interface, continiue (note that grep will run in quiet mode due to -q)
if ip link | grep -q "np0"; then
        # flash BSP
        nfp-fw-update -u -f
        # if flashed, then reboot
        if [ $? -eq 0 ]; then
                sleep 1
                reboot
        fi
fi

