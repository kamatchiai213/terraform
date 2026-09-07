# Terraform Workspace Lab — converted from your dev/ + prod/ folders

## What changed vs. your original repo
- `dev/` and `prod/` folders are gone. There is now **one root** (`main.tf`,
  `provider.tf`, `variables.tf`) that calls the **unmodified** `module/`.
- Environment differences now live only in `dev.tfvars` / `prod.tfvars`.
- `terraform.tfvars` was renamed to `dev.tfvars` / `prod.tfvars` because
  Terraform auto-loads a file literally named `terraform.tfvars` — naming
  them explicitly forces you to pass `-var-file` on purpose, which is the
  right habit once you're juggling more than one environment.
- Added a `check` block in `main.tf` as a workspace/tfvars mismatch guard
  (explained in the exercises below).
- `tag_name` is now prefixed with `terraform.workspace` automatically, so
  you can see the built-in value in action without a separate variable.

## Setup
```bash
cd terra_module_workspace
terraform init
```

## Lab 1 — create workspaces and see isolated state
```bash
terraform workspace list                 # only "default" exists so far
terraform workspace new dev
terraform workspace new prod
terraform workspace list                 # now shows default, dev, prod
```

## Lab 2 — plan/apply into dev
```bash
terraform workspace select dev
terraform plan  -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```
Inspect the state file that got created:
```bash
ls terraform.tfstate.d/dev/
```
Notice there is no `terraform.tfstate` in your root — it moved under
`terraform.tfstate.d/<workspace>/` once you're outside the default workspace.

## Lab 3 — plan/apply into prod, side by side
```bash
terraform workspace select prod
terraform plan  -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```
Now run:
```bash
terraform workspace select dev
terraform state list
terraform workspace select prod
terraform state list
```
Same code, two completely separate state files, two separate VPCs
(10.0.0.0/16 vs 20.0.0.0/16) — neither apply can clobber the other.

## Debugging exercises (do these on purpose — this is the real learning)

**1. Trigger the guardrail.**
```bash
terraform workspace select dev
terraform plan -var-file=prod.tfvars
```
This should fail the `check` block with an error telling you the workspace
and tfvars don't match. Read the error message, then fix it by selecting
the right workspace instead of editing the tfvars.

**2. Forget `-var-file` entirely.**
```bash
terraform plan
```
Terraform will interactively prompt you for every variable with no default
(ami, instance_type, etc.) — because there's no `terraform.tfvars` for it to
auto-load anymore. This is expected; it's what forces intentional env
selection. Ctrl-C out of it once you see the prompts.

**3. Break it for real: apply in `default` workspace.**
```bash
terraform workspace select default
terraform apply -var-file=dev.tfvars
```
The `check` block should stop this too (`expected_workspace = "dev"` but
current workspace is `default`). This is the scenario that, in a real repo
without a guardrail, is exactly how someone accidentally applies "dev-shaped"
config into whatever state the default workspace happens to hold.

**4. Clean up (avoid AWS charges — Free Tier or not):**
```bash
terraform workspace select dev
terraform destroy -var-file=dev.tfvars

terraform workspace select prod
terraform destroy -var-file=prod.tfvars
```

## Where this fits your AWS SAA-C03 plan
This maps directly onto your Day 4-6 (VPC + S3) and Day 19 (IaC) checklist
items — same VPC/subnet/IGW/route table/SG/EC2 resources you're already
studying, just deployed twice, cleanly, without hand-copying folders. It's
also a strong interview talking point for Day 27: "how do you manage
multiple environments in Terraform" is a very common question, and you'll
have actually built and broken the failure mode, not just read about it.
