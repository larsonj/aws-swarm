#!/usr/bin/env bash

echo Terraform AWS environment setup
echo "Bash version ${BASH_VERSION}"

export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_VPC_ID=vpc-95c708f3
export AWS_DEFAULT_INSTANCE_TYPE=t2.micro
export KEY_PATH=$HOME/.ssh/devops21.pem


