#!/usr/bin/env bash

echo Terraform AWS environment setup
echo "Bash version ${BASH_VERSION}"

export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_VPC_ID=vpc-95c708f3
export TF_VAR_vpc_id=vpc-95c708f3
export TF_VAR_subnet_id=subnet-277b026e
export AWS_DEFAULT_INSTANCE_TYPE=t2.micro
export AWS_KEY_PATH=$HOME/.ssh/devops21.pem
export AWS_KEY_NAME="devops21.pem"

export TF_VAR_swarm_manager_token=$(ssh -i devops21.pem \
ubuntu@$(terraform output swarm_manager_1_public_ip) \
docker swarm join-token -q manager)

export TF_VAR_swarm_worker_token=$(ssh -i devops21.pem \
ubuntu@$(terraform output swarm_manager_1_public_ip) \
docker swarm join-token -q worker)

export TF_VAR_swarm_manager_ip=$(terraform \
output swarm_manager_1_private_ip)

