

resource "aws_instance" "demo-import" {
    ami = "ami-0bea529386a62a2ad"
    instance_type = "t3.micro"
    key_name = "webserver"
    vpc_security_group_ids = ["sg-05ec53bdd892d7bf2"]
    subnet_id = "subnet-0ccf2c086af8d325f"


    tags = {
        Name = "demo-import"
        env = "default"
    }
    availability_zone = "us-west-2a"
}


