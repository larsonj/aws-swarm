echo Info Opening dm ingress ports 

SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filter "Name=group-name,Values=docker-machine" | jq -r '.SecurityGroups[0].GroupId')

# open docker swarm ports
for p in 2377 7946 4789; do
   aws ec2 authorize-security-group-ingress \
        --group-id $SECURITY_GROUP_ID \
        --protocol tcp \
        --port $p \
        --source-group $SECURITY_GROUP_ID
done

# open http, https from all inbound connections
for p in 80 443; do
   aws ec2 authorize-security-group-ingress \
        --group-id $SECURITY_GROUP_ID \
        --protocol tcp \
        --port $p \
        --cidr "0.0.0.0/0"
done
