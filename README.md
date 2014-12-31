test-linux-stable
=================

A tool for testing linux stable kernel

* Author

  Satoru Takeuchi <satoru.takeuchi@gmail.com>

* Summary

  This tool is for testing stable kernel automatically. If you run
  this tool, you can build, install, boot, and run any tests as you
  like with any release candidate stable kernels.

* Pre-requirement to run this tool

 - A host machine and a guest machine running on that host.
   Both are x86_64 systems.
 - Host side:
   - You can connect to guest's console via
     "virsh console <guest name>".
   - You can connect to "root@guest" via ssh without any
     password/passphrase.

       NOTE:
       Even if password/passphrase are absolutely needed,
       this tool works fine, however, you need to input
       them many time.
   - You can reboot the guest by combination of following
     commands.
     "virsh destroy <guest name>".
     "virsh start <guest name>".
 - Guest side:
   - grub2 is used as bootloader.
   - grub-reboot or grub2-reboot works properly.

* Usage

1. Edit the grub2 configuration file (only once).

   In the guest machine, add the entry for test kernel in the
   grub2's config file. Here is the example of my debian/jessy
   system's config file. Although the detail would be different
   with other distros, the name of menuentry, vmlinuz image,
   and initrd image shouldn't be changed.

===============================================
...
menuentry 'test-stable' {
        ...
        echo    'Loading test-stable kernel ...'
        linux   /boot/test-stable-vmlinuz root=<root device> ro console=ttyS0,115200n8
        echo    'Loading initial ramdisk ...'
        initrd  /boot/test-stable-initrd.img
}
...
===============================================

2. Move to the top directory of this tool.

  Run the following command.

============================
$ cd test-linux-stable
============================

3. Edit this tool's configuration file (sometimes).

  Tweak this tool's configuration file, "test-linux-stable.conf".
  "test-linux-stable.conf.sample" can be used as a sample.
  Please refer to the comments in this file here.

====================================
$ ${EDITOR} test-linux-stable.conf
====================================

4. Run the test.

  Run this tool with setting the test target kernel version.

==================================
$ bin/test-linux-stable <version>
==================================

  Here is the example of testing 3.12.2-rc1.

===================================
$ bin/test-linux-stable 3.12.2-rc1
===================================

  The test result is under results/<version>_<test datetime>.

    - log.txt: test log
    - kernel-config: .config of the kernel
    - ktest-config: the ktest config file.
