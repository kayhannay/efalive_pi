# efaLive PI project

This project contains a build script to create a SD card image with efaLive for the RaspberryPi. It is based on the [project that is used to build the official Raspberry Pi OS images](https://github.com/RPi-Distro/Pi-gen). (Previously known as Raspbian).

## Binaries and documentation

For more information about efaLive, have a look to the efaLive documentation on [my homepage](https://www.hannay.de/en/efalive/).

## Related projects
* [Debian GNU/Linux project](http://www.debian.-org/)
* [efaLive Docker](https://github.com/kayhannay/efalive_docker) - the Docker file to create an efaLive development environment
* [efaLive CD](https://github.com/kayhannay/efalive_cd) - the live CD build configuration
* [efaLive PI](https://github.com/kayhannay/efalive_pi) - efaLive image for Raspberry Pi (this project)
* [efaLive](https://github.com/kayhannay/efalive) - the glue code between Debian and the efa software
* [efa 2](https://github.com/kayhannay/efa2) - the Debian package configuration of the efa software
* [efa](http://efa.nmichael.de/) - the rowing and canoeing log book software

## Requirements
You need a Debian system. It might work on other Debian based systems as well, but it is not tested. Install the following packages to build:

```shell
apt-get install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
qemu-utils kpartx gpg pigz
```

## How to build
You can create a RaspberryPi image by calling

```shell
sudo ./build.sh
```

in the root directory of the project. The build script will download many files, so it will consume some space on your hard drive and will take some time, be patient.

Once the build has finished, you should have ain image file in work/efaLive/export-image. This can be written to a SD card by using dd

```shell
sudo dd if=work/efaLive/export-image/<SOME_IMAGE_NAME>.img of=/dev/mmcblk0 bs=1M
```

Be careful with the parameter for 'of='! YOU WILL OVERWRITE IMPORTANT DATA if you choose the wrong device here!

