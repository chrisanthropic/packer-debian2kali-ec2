packer-debian2kali-ec2
===========
An attempt at a Packer template to build an HVM Kali AMI that is identical to a Kali install using the official ISO.

## Requirements
* Packer
* AWS account

## About the AMI
First we start with the official Debian 64 HVM AMI [https://wiki.debian.org/Cloud/AmazonEC2Image/Wheezy](ami-e0efab88).

Next we replace the default Debian repos with the official Kali repos.

Then we install the standard Kali packages you find on the official ISO.

Lastly, we take care of some minor cleanup and housekeeping.

## How to use
Configure the variables in the kali.json template to match your needs. The first 4 MUST be changed if you want things to work.

```
"aws_access_key": "YOUR-ACCESS-KEY-HERE",
"aws_secret_key": "YOUR-SECRET-KEY-HERE",
"subnet_id": "YOUR-SUBNET-ID-HERE",
"security_group_id": "YOUR-SECURITY-GROUP-ID-HERE",
```

Run packer to create the AMI: `packer build kali.json`

You now have a fully updated HVM Kali 1.1 AMI available in your AWS EC2 account.