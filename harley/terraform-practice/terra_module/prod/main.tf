module "terraform_module" {
    source = "../module"
    ami = var.ami
    instance_type = var.instance_type
    tag_name = var.tag_name
    availability_zone = var.availability_zone
    key_name = var.key_name
    cidr_blocks = var.cidr_blocks
    subnet_cidr_blocks = var.subnet_cidr_blocks
    vpc_cidr_blocks = var.vpc_cidr_blocks
    }



