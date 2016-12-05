#!/usr/bin/env bash 
MANAGER_TOKEN=$(docker swarm join-token -q manager)

for i in 2 3; do
   docker-machine create \
      --driver amazonec2 \
      --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID \
      --amazonec2-zone ${AWS_ZONE[1]} \
      --amazonec2-subnet-id subnet-277b026e \
      --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE \
      --amazonec2-tags "type,manager" \
   swarm-$i

   IP=$(aws ec2 describe-instances \
      --filter Name=tag:Name,Values=swarm-$i \
      | jq -r ".Reservations[0].Instances[0].PrivateIpAddress")
   
   eval $(docker-machine env swarm-$i)
   
   docker swarm join \
      --token $MANAGER_TOKEN \
      --advertise-addr $IP \
   $MANAGER_IP:2377
done


WORKER_TOKEN=$(docker swarm join-token -q worker)

for i in 4 5; do
docker-machine create \
   --driver amazonec2 \
   --driver amazonec2 \
   --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID \
   --amazonec2-zone ${AWS_ZONE[1]} \
   --amazonec2-subnet-id subnet-277b026e \
   --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE \
   --amazonec2-tags "type,manager" \
swarm-$i

IP=$(aws ec2 describe-instances \
   --filter Name=tag:Name,Values=swarm-$i \
   | jq -r ".Reservations[0].Instances[0].PrivateIpAddress")

eval $(docker-machine env swarm-$i)

docker swarm join \
   --token $WORKER_TOKEN \
   --advertise-addr $IP \
   $MANAGER_IP:2377
done

