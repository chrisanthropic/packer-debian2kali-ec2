packer-debian2kali-ec2
===========
An attempt at a Packer template to build an HVM Kali AMI that is identical to a Kali install using the official ISO.

## Requirements
* Packer
* AWS account

## About the AMI
First we start with an official Debian 64 HVM AMI [ami-e0efab88](https://wiki.debian.org/Cloud/AmazonEC2Image/Wheezy).

Next we replace the default Debian repos with the official Kali repos.

Then we install the standard Kali packages you find on the official ISO.

Lastly, we take care of some minor cleanup and housekeeping.

### Regions
This template creates a us-east-1 AMI by default. If want to build an AMI in a different region you can edit the following lines in kali.json according to the available list [here](https://wiki.debian.org/Cloud/AmazonEC2Image/Wheezy):

```
"region": "us-east-1",
"source_ami": "ami-e0efab88"
```

## How to use
Configure the variables in the kali.json template to match your needs. The first 4 MUST be changed if you want things to work.

```
"aws_access_key": "YOUR-ACCESS-KEY-HERE",
"aws_secret_key": "YOUR-SECRET-KEY-HERE",
"subnet_id": "YOUR-SUBNET-ID-HERE",
"security_group_id": "YOUR-SECURITY-GROUP-ID-HERE",
```

Run packer to create the AMI: `packer build kali.json`

You now have a fully updated HVM Kali 1.1 AMI available in your AWS EC2 account. Create an instance with the AMI and SSH in with user `admin`.