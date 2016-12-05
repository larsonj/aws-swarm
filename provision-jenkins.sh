docker-machine -D create \
--driver amazonec2 \
--amazonec2-access-key $AWS_ACCESS_KEY \
--amazonec2-secret-key $AWS_SECRET_KEY \
--amazonec2-vpc-id mgiWebVPC \
--amazonec2-zone $AWS_ZONE \
--amazonec2-region e \
--amazonec2-instance-type t2.micro \
--amazonec2-root-size 10 \
jenkins

