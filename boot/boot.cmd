echo "------------ X6100 boot script ------------"
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p3 rootwait panic=10 fbcon=rotate:3 ignore_loglevel
fatload mmc 0:2 0x46000000 zImage
fatload mmc 0:2 0x47000000 ${fdtfile}
fatload mmc 0:2 0x48000000 initrd
bootz 0x46000000 0x48000000:0x$filesize 0x47000000
