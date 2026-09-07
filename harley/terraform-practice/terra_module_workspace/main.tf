module "terraform_module" {
  source = "./module"

  ami                = var.ami
  instance_type      = var.instance_type
  tag_name           = "${terraform.workspace}-${var.tag_name}"
  availability_zone  = var.availability_zone
  key_name           = var.key_name
  cidr_blocks        = var.cidr_blocks
  subnet_cidr_blocks = var.subnet_cidr_blocks
  vpc_cidr_blocks    = var.vpc_cidr_blocks
}

# --- Workspace guardrail ---------------------------------------------------
# terraform.workspace is a built-in value — no variable needed to read it.
# This check compares it against the expected_workspace value declared in
# whichever .tfvars file you passed with -var-file, and fails fast if they
# don't match (e.g. you're in the "default" workspace but loaded prod.tfvars).
check "workspace_matches_tfvars" {
  assert {
    condition     = terraform.workspace == var.expected_workspace
    error_message = "Current workspace is '${terraform.workspace}' but this .tfvars file expects '${var.expected_workspace}'. Run: terraform workspace select ${var.expected_workspace}"
  }
}
