# Remove SSH key pairs according to AWS requirements for shared AMIs: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub

# Remove all bash history according to AWS best practices: http://aws.amazon.com/articles/0155828273219400
find /root/.*history /home/*/.*history -exec rm -f {}