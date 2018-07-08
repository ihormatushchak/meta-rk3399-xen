FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-mkimage-native systemd"

# git commit hash for Xen's RELEASE-4.10.0 tag
SRCREV_xen = "44ce23c0d811c08bb559c46a171b234c3ff714a2"
SRC_URI = "git://xenbits.xen.org/xen.git;protocol=git;nobranch=1;name=xen"
SRCREV = "${AUTOREV}"
XEN_REL="4.10.0"

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
