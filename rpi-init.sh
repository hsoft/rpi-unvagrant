#!/bin/sh

if [ -z $1 ]; then
    echo "You need to supply a new hostname for your rpi"
    exit 1
fi

SSHOPTS=(-o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null")

# First things first: wiggle your big toe. Put your public key in pi's authorized_keys
echo "Sending your public key to your RPI. A password will only be needed this once."
echo "Remember, it's 'raspberry'"

cat ~/.ssh/id_rsa.pub | ssh pi@raspberrypi.local "${SSHOPTS[@]}" \
    'cat > tmpkey; mkdir -p .ssh; mv tmpkey .ssh/authorized_keys; chmod 0600 .ssh/authorized_keys'

echo "Delete the default password"
ssh pi@raspberrypi.local "${SSHOPTS[@]}" 'sudo passwd --delete pi'

echo "Changing the hostname to $1"
echo $1 | ssh pi@raspberrypi.local "${SSHOPTS[@]}" 'cat | sudo tee /etc/hostname; sudo hostname -F /etc/hostname; sudo systemctl restart avahi-daemon'

echo "Your RPI is now ready to provision at pi@${1}.local!"
