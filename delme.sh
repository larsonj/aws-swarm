#!/usr/bin/env bash 

# create primary swarm manager
docker-machine create \
   --driver amazonec2 \
   --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID \
   --amazonec2-zone ${AWS_ZONE[1]} \
   --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE \
   --amazonec2-tags "type,manager" \
   swarm-1

export MANAGER_IP=$(aws ec2 describe-instances --filter Name=tag:Name,Values=swarm-1 | jq -r ".Reservations[0].Instances[0].PrivateIpAddress")
echo MANAGER_IP=$MANAGER_IP

eval $(docker-machine env swarm-1)

docker swarm init --advertise-addr $MANAGER_IP

docker node ls

MANAGER_TOKEN=$(docker swarm join-token -q manager)

