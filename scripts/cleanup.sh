# Remove SSH key pairs according to AWS requirements for shared AMIs: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub

# Remove all history files
shred -u ~/.*history