resource "aws_s3_bucket" "terraform_state" {
   bucket = "larsonj.aws-swarm.terraform.state"
   versioning {
      enabled = true
   }
   lifecycle {
      #prevent_destroy = true
   }
}
