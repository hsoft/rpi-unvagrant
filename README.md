# rpi-unvagrant

*Replace Vagrant with Raspberry Pis.*

Virtualizing environments is so... last week. Why virtualize when you can have the same convenience
from a Raspberry Pi?

The default setup for [Raspbian][raspbian] have several features that make our life easy:

* Default `pi` sudoer with `raspberry` password.
* SSH daemon running on startup.
* Default hostname being `raspberrypi`.
* Avahi (Bonjour, zeroconf) daemon running on startup.

You know what this means? This means that You can ssh into a freshly `dd`'ed Raspbian SD card with
`pi@raspberrypi.local` connected on your local network from any other machine on that network with
the password `raspberry`.

This means that it only takes a few steps to go from an empty SD card to an environment that you
can provision like you would with any (debian) vagrant box:

1. Download the [Raspbian Lite][raspbian] image.
1. Plug in a SD card.
1. `dd` your image into it.
1. [Resize the second partition of the card][resize-partition] so it takes the whole space.
1. Put your SD card in your Raspberry Pi.
1. Plug it to an ethernet cable linking to your local network.
1. Power it up and wait a minute or two.
1. Run `./rpi-init.sh somehostname`
1. You can now SSH into `pi@somehostname.local` with your SSH private key!

You're now ready to provision your new environment with whatever tool you prefer.

[resize-partition]: http://positon.org/resize-an-ext3-ext4-partition
[raspbian]: https://www.raspberrypi.org/downloads/raspbian/
