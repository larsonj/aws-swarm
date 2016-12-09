terraform remote config \
    -backend=s3 \
    -backend-config="bucket=larsonj.aws-swarm.terraform.state" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="encrypt=true"
