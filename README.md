packer-debian2kali-ec2
===========
An attempt at a Packer template to build an HVM Kali AMI that is identical to a Kali install using the official ISO.
Newest release has been updated for `kali-rolling`, check previous release(s) for `kali-2.0`.

## Requirements
* Packer
* AWS account

## About the AMI
First we start with an official Debian 64 HVM AMI [ami-f0e7d19a](https://wiki.debian.org/Cloud/AmazonEC2Image/).

Next we replace the default Debian repos with the official Kali repos.

Then we install the standard Kali packages you find on the official ISO.

Lastly, we take care of some minor cleanup and housekeeping.

The result (for Kali 1.7) is this public AMI - ami-c45a71ac

### Regions
This template creates a us-east-1 AMI by default. If want to build an AMI in a different region you can edit the following lines in kali.json according to the available list [here](https://wiki.debian.org/Cloud/AmazonEC2Image/):

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

You now have a fully updated HVM Kali-rolling AMI available in your AWS EC2 account. Create an instance with the AMI and SSH in with user `admin`.

## AMI 
Or, if you trust us, you can use the public AMI we created with this repo: - ami-c45a71ac (NOTE, this is old Kali 1.7)

## Disclaimer
You're free to use this code however you want but I'm not responsible for anything that happens as a result. Please see the license for more details.
