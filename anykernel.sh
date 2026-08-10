### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
## edited for Samsung Galaxy Tab A 8.0 LTE (SM-T355 / SM-T355Y, codename gt58lte)

### AnyKernel setup
# global properties
properties() { '
kernel.string=Custom Kernel for SM-T355/SM-T355Y (gt58lte)
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=gt58lte
device.name2=gt58ltebmc
device.name3=SM-T355
device.name4=SM-T355Y
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
# TODO VERIFY before flashing: run `ls -la /dev/block/bootdevice/by-name/`
# from a TWRP terminal / adb shell and confirm "boot" points to a real
# partition on THIS device before trusting this path.
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=0;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
dump_boot; # unpacks current boot.img: kernel, ramdisk, and dt (QCDT-signed,
           # matches this device's dtbTool-built dt.img) via unpackelf

# no ramdisk edits: this is a kernel/dtb swap only. The zImage and dt.img
# dropped at the zip root replace the extracted kernel and dt automatically
# in write_boot -> flash_boot (see tools/ak3-core.sh: it looks for
# $AKHOME/dt.img before falling back to the dt just extracted above).
# If you need init.rc/fstab edits later, add backup_file/replace_string/
# insert_line calls here against files that actually exist in THIS
# device's ramdisk (check with: dump_boot; then look in $SPLITIMG).

write_boot; # repacks kernel + ramdisk + dt into boot-new.img and flashes BLOCK
## end boot install
