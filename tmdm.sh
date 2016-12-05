#!/usr/bin/env bash

echo "Bash version ${BASH_VERSION}"

export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_SUBNET_ID=subnet-277b0263
export AWS_DEFAULT_ZONE=e
export AWS_DEFAULT_VPC_ID=vpc-95c708f3
export AWS_DEFAULT_INSTANCE_TYPE=t2.nano

zonesArr=(c b c d e)
subnetsArr=(ssubnet-4258f97e subnet-277b026 subnet-4258f97e subnet-77951b5a subnet-77951b5a)

let "idx = 0"
for val in "${zonesArr[@]}"
do
   let "idx++"

   AWS_ZONE[$idx]=$val
   echo AWS_ZONE[$idx]=$val

   AWS_SUBNET[$idx]=${subnetsArr[$idx]}
   echo AWS_SUBNET[$idx]=${subnetsArr[$idx]}

done
