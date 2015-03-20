# Remove SSH key pairs according to AWS requirements for shared AMIs: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
sudo shred -u /home/admin/.ssh/*

# Wipe our logs
echo > /var/log/auth.log
echo > /var/log/cloud-init.log
echo > /var/log/daemon.log
echo > /var/log/debug
echo > /var/log/dmesg
rm /var/log/dmesg.*
echo > /var/log/dpkg.log
echo > /var/log/kern.log
echo > /var/log/lastlog
echo > /var/log/messages
echo > /var/log/pm-powersave.log
echo > /var/log/syslog
echo > /var/log/user.log
echo > /var/log/wtmp
echo > /var/log/Xorg.0.log
echo > /var/log/apt/history.log
echo > /var/log/ConsoleKit/history
echo > /var/log/gdm3/:0-greeter.log
echo > /var/log/gdm3/:0.log
echo > /var/log/gdm3/:0-slave.log

# Clear our Bash history
history -c
history -w