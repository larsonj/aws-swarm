#!/usr/bin/env bash

echo "Bash version ${BASH_VERSION}"

export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_SUBNET_ID=subnet-277b0263
export AWS_DEFAULT_ZONE=e
export AWS_DEFAULT_VPC_ID=vpc-95c708f3
export AWS_DEFAULT_INSTANCE_TYPE=t2.nano

# if there are multiple subnets per zone then you need to specify a public subnet for the dm 
# create command. 
# if there is one public subnet per zone then all you need to specify is the AWS zone 
# zones and subnets arrays need to align, have same # of elements
# subnets must have public ingress 
# todo: refactor conditional subnet selection when private subnets are detected
zonesArr=(c b c d e)
subnetsArr=(subnet-4258f97e subnet-77951b5a subnet-4258f97e subnet-f7db58ac subnet-77951b5a)

let "idx = 0"
for val in "${zonesArr[@]}"
do
   AWS_ZONE[$idx]=$val
   AWS_SUBNET[$idx]="${subnetsArr[$idx]}"

   echo AWS_ZONE[$idx]=$val '=>' AWS_SUBNET[$idx]="${subnetsArr[$idx]}"

   let "idx++"
done

