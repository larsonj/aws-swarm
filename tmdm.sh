echo ===========================================================================================
echo docker-machine $1 create --driver amazonec2 --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID --amazonec2-zone ${AWS_ZONE[1]} --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE --amazonec2-tags "type,manager" swarm-1
echo ===========================================================================================

echo docker-machine $1 create \
   --driver amazonec2 \
   --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID \
   --amazonec2-zone ${AWS_ZONE[1]} \
   --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE \
   --amazonec2-tags "type,manager" \
   swarm-1-test

docker-machine $1 create \
   --driver amazonec2 \
   --amazonec2-vpc-id $AWS_DEFAULT_VPC_ID \
   --amazonec2-zone ${AWS_ZONE[1]} \
   --amazonec2-instance-type $AWS_DEFAULT_INSTANCE_TYPE \
   --amazonec2-tags "type,manager" \
   swarm-1-test

echo ===========================================================================================
echo export MANAGER_IP=$(aws ec2 describe-instances --filter Name=tag:Name,Values=swarm-1 | jq -r ".Reservations[2].Instances[0].PrivateIpAddress")
echo ===========================================================================================

export MANAGER_IP=$(aws ec2 describe-instances --filter Name=tag:Name,Values=swarm-1 | jq -r ".Reservations[0].Instances[0].PrivateIpAddress")


#   --amazonec2-subnet-id ${AWS_SUBNET[1]} \
