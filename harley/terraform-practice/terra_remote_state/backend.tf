terraform {
  backend "s3" {
    bucket         = "my-terraform-state-kamatchiai213-2026" # your bucket name from Step 1
    key            = "terra_remote_state/terraform.tfstate"
    region         = "us-west-2"
    use_lockfile = true
    encrypt        = true
  }
}