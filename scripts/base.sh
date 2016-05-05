#!/bin/bash

set -e
set -o pipefail

#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
cat > /etc/apt/sources.list <<EOL
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOL

rm -rf /etc/apt/sources.list.d/*

#### Download and import the official Kali Linux key
wget -q -O - https://www.kali.org/archive-key.asc | gpg --import
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
gpg -a --export ED444FF07D8D0BF6 | apt-key add -


#### Non-interactive frontend to avoid stdin errors with debconf.
export DEBIAN_FRONTEND=noninteractive

#### Update our apt db so we can install kali-keyring
apt-get update

#### Install the Kali keyring
apt-get -y --force-yes install kali-archive-keyring

#### Update our apt db again now that kali-keyring is installed
apt-get update

#### Preconfigure things so our install will work without any user input
## mysql
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password'    
debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.5/postrm_remove_databases boolean false'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.5/start_on_boot boolean true'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.5/nis_warning note'  
debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.5/really_downgrade boolean false'

## Kismet
debconf-set-selections <<< 'kismet kismet/install-setuid boolean false'
debconf-set-selections <<< 'kismet kismet/install-users string'

## sslh
debconf-set-selections <<< 'sslh sslh/inetd_or_standalone select standalone'

#### Install aptitude to automatically resolve dependency issues with the packages below.
apt-get -y --force-yes install aptitude

#### Install the base software
## List taken from the official Kali-live-build script at: http://git.kali.org/gitweb/?p=live-build-config.git;a=blob_plain;f=config/package-lists/kali.list.chroot;hb=HEAD
aptitude -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install kali-linux
aptitude -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install kali-linux-full
aptitude -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install kali-desktop-gnome

#### Update to the newest version of Kali
aptitude -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" upgrade

#### Since we're automating via force-confnew, one of the upgrades overwrites our sources.list so fix it again
#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
cat > /etc/apt/sources.list <<EOL
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOL

#### Clean up after apt-get
apt-get -y autoremove --purge
apt-get -y clean
  
