test-linux-stable
=================

tools for testing linux stable

* Author

  Satoru Takeuchi <satoru.takeuchi@gmail.com>

* Summary

  This tool is for testing stable kernel automaticall. If you run
  this tool, you can boot, install, boot, and run any test as you
  like with any release candidate stable kernels.

* Pre-requirement to run this tool.

 - The host machine and a guest machine running on this host.
   Both are x86_64 system.
 - Host side:
   - You can can access to guest via virsh console.
   - You can access to root@guest via ssh without any password/passphrase.
   - You can reboot guest via virsh destroy and virsh start.
 - Guest side:
   - grub2 is used as bootloader.
   - grub-reboot or grub2-reboot works properly.

* Usage

1. Add the entry for test kernel in the guest's config file
   of grub2 as root. Here is the example of my debian/jessy
   system. The detail would be different with other distros.
   
===============================================
menuentry 'test-stable' {
        ...
        echo    'Loading test-stable kernel ...'
        linux   /boot/vmlinuz-test-stable root=<root device> ro console=ttyS0,115200n8
        echo    'Loading initial ramdisk ...'
        initrd  /boot/initrd.img-test-stable
}
===============================================

2. Move to the top directory of this tool.

============================
$ cd test-linux-stable
============================

3. Tweak the configuration file, test-linux-stable.conf in this directory.
   Please set each option with reading the comment above each ones.

====================================
$ ${EDITOR} test-linux-stable.conf
====================================

4. Run test with setting the kernel version which you want to test.

==================================
$ bin/test-linux-stable 3.12.2-rc1
==================================

  This program get stable-rc kernel, configure, build, boot, and run your own test
  automatically. The test result is in log/test-stable.log
