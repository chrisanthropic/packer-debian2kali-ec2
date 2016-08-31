# The Debian AMI uses the Syslinux bootloader but Kali uses Grub2 so let's use Grub2

#### Preconfigure our settings so everything is automated without user input
debconf-set-selections <<< 'grub-installer grub-installer/only_debian boolean true'
debconf-set-selections <<< 'grub-installer grub-installer/with_other_os boolean true'
debconf-set-selections <<< 'grub-pc grub-pc/install_devices multiselect /dev/xvda'

# Install grub2
aptitude -y install grub2