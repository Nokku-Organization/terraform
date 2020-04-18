

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

