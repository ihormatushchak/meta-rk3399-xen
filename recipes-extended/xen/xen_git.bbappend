FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-mkimage-native systemd"

# git commit hash for Xen's RELEASE-4.10.0 tag
SRCREV_xen = "44ce23c0d811c08bb559c46a171b234c3ff714a2"
SRC_URI = "git://xenbits.xen.org/xen.git;protocol=git;nobranch=1;name=xen"
SRCREV = "${AUTOREV}"
XEN_REL="4.10.0"

SRC_URI += "\
    file://0001-xen-arm-earlyprintk-configuration-for-rk3399-boards.patch \
    file://0001-xen-drivers-char-console.c-icrease-ring-size.patch \
    "

EXTRA_OEMAKE += " CONFIG_QEMU_XEN=n CONFIG_DEBUG=y debug=y CONFIG_EARLY_PRINTK=rk3399"

FILES_${PN}-devd += "\
    ${systemd_unitdir}/system/xendriverdomain.service \
    "

SYSTEMD_SERVICE_${PN}-devd = "\
    xendriverdomain.service \
    "

SYSTEMD_PACKAGES += "${PN}-devd"

RDEPENDS_${PN}-efi = " \
    bash \
    python \
    "

do_install_append() {
  rm ${D}/usr/share/pkgconfig/xencall.pc
}

do_deploy_append() {

	if [ -f ${D}/boot/xen ]; then
		uboot-mkimage -A arm64 -C none -T kernel -a 0x02000000 \
		-e 0x02000000 -n "XEN" -d ${D}/boot/xen \
		${D}/boot/xen-${MACHINE}.uImage
	fi

	if [ -f ${D}/boot/xen-${MACHINE}.uImage ]; then
		install -m 0644 ${D}/boot/xen-${MACHINE}.uImage ${DEPLOYDIR}/xen-${MACHINE}.uImage
	fi
	# remove unneeded files
	rm ${DEPLOYDIR}/xen-${MACHINE}
	rm ${DEPLOYDIR}/xen-${MACHINE}.efi
}
