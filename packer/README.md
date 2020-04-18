## In this Example we will show the usage of packer by demonstrating an example of automated creation of desired ami and automatic insertion in default terraform variables file


### Installation:
wget https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip

unzip packer_1.4.1_linux_amd64.zip
sudo mv packer /usr/local/bin


### Code explanation:
In aboce shell script we are invoking packing such that it creates our descired ami with the configuration in package-example.json file.
Then we are extracting the ami-id and inserting in terraform variables file.

### Resources:
https://www.packer.io/docs/builders/amazon-instance.html

https://www.packer.io/docs/provisioners/powershell.html

https://learn.hashicorp.com/terraform/operations/packer-images


^awsome-.*   =>awsome-dev,awsome-service
regex101.com


#### Actual basic flow:

Basic flow is》》 code checkout from github on  jenkins slave node 》》 code build on jenkins node 》》 uploading binary to nexus repo》》 calling ansible tower in jenkins》》 corresponding ansible script run on ansible tower & do deployment



