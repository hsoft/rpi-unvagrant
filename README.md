# rpi-unvagrant

*Replace Vagrant with Raspberry Pis.*

Virtualizing environments is so... last week. Why virtualize when you can have the same convenience
from a Raspberry Pi?

The default setup for [Raspbian][raspbian] have several features that make our life easy:

* Default `pi` sudoer with `raspberry` password.
* SSH daemon running on startup if properly configured.
* Avahi (Bonjour, zeroconf) daemon running on startup.

With only a few tweaks following a fresh `dd`, we can easily spawn ready-to-provision RPIs at our
leisure. The bash script included in this repo helps doing it even faster. Here are the steps:

1. Download the [Raspbian Lite][raspbian] image.
1. Plug in a SD card in your machine.
1. `lsblk` to identify the path of the SD card device. For example, `/dev/sdb`.
1. Think of a hostname you want to your new RPI. For example, `example.local`.
1. Run `./rpi-init.sh /path/to/raspbian.img /dev/sdb example`. Sudo needed.
1. Put your SD card in your Raspberry Pi.
1. Plug it to an ethernet cable linking to your local network.
1. Power it up and wait a minute or two.
1. You can now SSH into `pi@somehostname.local` with your SSH private key!

You're now ready to provision your new environment with whatever tool you prefer.

[raspbian]: https://www.raspberrypi.org/downloads/raspbian/
