#!/bin/bash

set -e
set -o pipefail

#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
cat > /etc/apt/sources.list <<EOL
deb http://http.kali.org/kali kali main non-free contrib
deb http://security.kali.org/kali-security kali/updates main contrib non-free
EOL

#### Download and import the official Kali Linux key
wget -q -O - https://www.kali.org/archive-key.asc | gpg --import

#### Update our apt db
apt-get update

#### Install the Kali keyring
apt-get -y --force-yes install kali-archive-keyring

#### Preconfigure things so our install will work without any user input
## mysql
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password'    
debconf-set-selections <<< 'mysql-server-5.5 mysql-server-5.5/postrm_remove_databases boolean false'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server-5.5/start_on_boot boolean true'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server-5.5/nis_warning note'  
debconf-set-selections <<< 'mysql-server-5.5 mysql-server-5.5/really_downgrade boolean false'

## Kismet
debconf-set-selections <<< 'kismet kismet/install-setuid boolean false'
debconf-set-selections <<< 'kismet kismet/install-users string'

## sslh
debconf-set-selections <<< 'sslh sslh/inetd_or_standalone select standalone'

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND=noninteractive

#### Install the base software
## List taken from the official Kali-live-build script at: http://git.kali.org/gitweb/?p=live-build-config.git;a=blob_plain;f=config/package-lists/kali.list.chroot;hb=HEAD
apt-get -y --force-yes install kali-linux
apt-get -y --force-yes install kali-desktop-live
apt-get -y --force-yes install kali-linux-full
apt-get -y --force-yes install kali-desktop-gnome

#### Clean up after apt-get
apt-get -y autoremove --purge
apt-get -y clean
  