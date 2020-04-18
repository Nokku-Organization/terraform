wget https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip

unzip packer_1.4.1_linux_amd64.zip
sudo mv packer /usr/local/bin



build-and-launch.sh:

#!/bin/bash

#packer build packer-example.json
#ARTIFACT=`packer build -machine-readable packer-example.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`


abc=`echo "*****************************************"`
echo "$abc"

ARTIFACT=`packer build packer-example.json |  awk '/./{line=$0} END{print line}' |  cut -d : -f 2 |sed -e 's/^[[:space:]]*//'`

#abc= awk '/./{line=$0} END{print line}' my_file.txt | cut -d : -f 2 |sed -e 's/^[[:space:]]*//'
#echo "$abc"


echo "*****************************************"
echo "$ARTIFACT"

echo 'variable "AMI_ID" { default = "'$ARTIFACT'" }' > amivar.tf


###################################################

packer-example.json:

{
  "variables": {
  },
  "builders": [{
    "type": "amazon-ebs",
    "region": "us-east-1",
    "source_ami": "ami-035b3c7efe6d061d5",
    "instance_type": "t2.micro",
    "ssh_username": "ec2-user",
    "ami_name": "packer-example-6",
"temporary_security_group_source_cidrs":["54.172.236.90/32","host=where you are running coe"]
  }],
  "provisioners": [{
    "type": "shell",
    "inline": ["sudo yum install git -y"],
    "pause_before": "10s"
  }]
}


https://www.packer.io/docs/builders/amazon-instance.html

https://www.packer.io/docs/provisioners/powershell.html

https://learn.hashicorp.com/terraform/operations/packer-images



Basic flow is》》 code checkout from github on  jenkins slave node 》》 code build on jenkins node 》》 uploading binary to nexus repo》》 calling ansible tower in jenkins》》 corresponding ansible script run on ansible tower & do deployment



^awsome-.*   =>awsome-dev,awsome-service
regex101.com
