DESCRIPTION = "Linux kernel for Rockchip rk3399 based ibox3399 board"

require recipes-kernel/linux/linux-yocto.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"
COMPATIBLE_MACHINE = "ibox3399"

KERNEL_9TRIPOD_URL = "git://github.com/ihormatushchak/k9tripod.git"
BRANCH = "kernel-4.4.52-9tripod-devel"
SRCREV = "1b147c2b494fd2ec84905b77f29758aeb380e048"

SRC_URI = "${KERNEL_9TRIPOD_URL};protocol=git;nocheckout=1;branch=${BRANCH}"

LINUX_VERSION ?= "4.4.52"
PV = "${LINUX_VERSION}+git${SRCPV}"
PR = "r1"

SRC_URI_append = " \
    file://defconfig \
"
