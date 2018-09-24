# Copyright (C) 2014 Romain Perier <romain.perier@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

require recipes-core/images/core-image-minimal.bb

DESCRIPTION = "Basic image for Rockchip devices. This is a small image just \
capable of allowing a device to boot with packages management, \
ssh server and development tools."
IMAGE_FEATURES_append = " package-management ssh-server-dropbear"

LICENSE = "MIT"

IMAGE_INSTALL_append = "\
	xen-base \
	xen-hypervisor \
	xen-flask \
"

IMAGE_INSTALL += "\
	xen-scripts-common \
	xen-devd \
	xen-xl \
	xen-scripts-block \
	xen-xenstore \
	xen-scripts-network \
"

IMAGE_INSTALL += "\
	libdrm \
	libdrm-tests \
"

# add 100MB to rootfs
IMAGE_ROOTFS_EXTRA_SPACE = "102400"
