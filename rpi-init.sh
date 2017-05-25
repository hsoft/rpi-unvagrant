#!/bin/sh

if [ -z $1 ]; then
    echo "You need to supply a path to the sd card device (ex: /dev/sdb)"
    exit 1
fi

if [ -z $2 ]; then
    echo "You need to supply a path to the raspbian image file to use"
    exit 1
fi

if [ -z $3 ]; then
    echo "You need to choose a hostname for your raspberry pi"
    exit 1
fi

if [ ! -f ~/.ssh/id_rsa.pub ] ; then
    echo "You should have a ~/.ssh/id_rsa.pub file so we can provision it to the SD card"
    exit 1
fi

TMPPATH=/tmp/rpi-unvagrant
HOSTNAME=$3

echo "Writing raspbian image to SD card..."

sudo dd if=$1 of=$2 bs=4M

echo "Enable SSH"

mkdir -p ${TMPPATH}
sudo mount ${1}1 ${TMPPATH}
sudo touch ${TMPPATH}/ssh
sudo umount ${TMPPATH}

echo "Provision your own ssh pubkey"

sudo mount ${1}2 ${TMPPATH}
sudo mkdir -p ${TMPPATH}/home/pi/.ssh
sudo cp ~/.ssh/id_rsa.pub ${TMPPATH}/home/pi/.ssh/authorized_keys
sudo chown -R 1000 ${TMPPATH}/home/pi/.ssh

echo "Disabling default password for the user pi"

sudo sed -i 's/pi:[^:]*:/pi:\*:/' ${TMPPATH}/etc/shadow

echo "Changing the hostname to $HOSTNAME"
echo $HOSTNAME | sudo tee ${TMPPATH}/etc/hostname

echo "Updating /etc/hosts"
sudo sed -i -e "s/raspberrypi/$HOSTNAME/" ${TMPPATH}/etc/hosts

sync

sudo umount ${TMPPATH}
rmdir ${TMPPATH}

echo "Your SD card is now ready!"
echo "Boot your RPI with this card and provision it at pi@$HOSTNAME.local"
