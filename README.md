Debian on Xiegu X6100
=====================

This repo will build an almost entirely stock Debian SD card image,
suitable for booting on a Xiegu X6100 radio.

This is heavily based on [Plebian Linux](https://plebian.org/) for
PINE64 devices.

Previous work:

 * [x6100-armbian](https://github.com/Links2004/x6100-armbian) - Armbian on X6100
 * [X6100Buildroot](https://github.com/AetherRadio/X6100Buildroot) - a Buildroot configuration for X6100
 * [X6100 de R1CBU](https://r1cbu.ru/) - alternate firmware for the X6100
 
Disclaimer
----------

This is an OS image derived, in part, by reverse engineering the X6100
hardware. It might steal your lunch, or render your radio
inoperable. The Allwinner CPU in the radio is fairly well supported by
Debian; the radio hardware it is attached to is not. It is your
responsibility to understand these risks and and continue only if you
feel comfortable doing so.

Current Status
--------------

This image is a work in progress. It builds, but don't expect too much
more just yet.

How to Build
------------

### u-boot

Make sure you cloned the submodules:

```
git submodule init
git submodule update
```

Get an `arm-linux-gnueabihf` cross compiler. On Debian, you can use

```
sudo apt-get install build-essential crossbuild-essential-armhf
```

To build:

```
cd u-boot
make mrproper
cp ../u-boot-config/sun8i-r16-x6100_defconfig configs/sun8i-r16-x6100_defconfig
cp ../u-boot-config/sun8i-r16-x6100.dts arch/arm/dts/
make sun8i-r16-x6100_defconfig
CROSS_COMPILE=arm-linux-gnueabihf- make -j$(nproc)
```

Now, compile the boot script and move the resulting files into place:

```
./tools/mkimage -C none -A arm -T script -d ../boot/boot.cmd ../boot/boot.scr
cp u-boot-sunxi-with-spl.bin ../boot/
cp arch/arm/dts/sun8i-r16-x6100.dtb ../boot/
```

### Debian Image

Get a copy of [debos](https://github.com/go-debos/debos). On Debian,
you can use:

```
sudo apt-get install debos
```

Build the SD card image:

```
debos debos.yaml
```

This step can take a while. When finished, your fresh SD card image
will be at `debian-bookworm-x6100.img` or something similar.

Using the Image
---------------

Flash the image to an SD card using your favorite tool, and then stick
it in the radio and boot. **The username and password are both
`radio`**. You will be asked to change this password when you first
log in.
