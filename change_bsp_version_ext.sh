#!/bin/bash

# $1 input is last part of path to bsp version e.g. /interim/deb/
# $2 input is PCI address e.g. 0000:07:00.0
# $3 input is fw file name e.g. nic_AMDA0097-0001_2x40.nffw
# $4 input is bsp version e.g. 22.10~00111.main.282e56a-0

# install BSP version
apt-get install -y /mnt/cloud/binaries/nfp-bsp/$1nfp-bsp*$4.bionic_amd64.deb --allow-downgrades

# ensure interfaces are visible by reloading the driver
rmmod nfp
insmod /root/nfp-drv-kmods-private/src/nfp.ko nfp_pf_netdev=0 nfp_dev_cpp=1
nfp-nsp -Z $2 -R
nfp-nsp -Z $2 -F /root/agilio-nic-firmware-23.01-0/$3
rmmod nfp
insmod /root/nfp-drv-kmods-private/src/nfp.ko nfp_dev_cpp=1
sleep 2
ip link

# if ip link shows an interface, continiue (note that grep will run in quiet mode due to -q)
if ip link | grep -q "np0"; then
        # flash BSP
        nfp-fw-update -Z $2 -u -f
        # if flashed, then reboot
        if [ $? -eq 0 ]; then
                sleep 1
                reboot
        fi
fi
