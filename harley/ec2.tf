resource "aws_instance" "webserver" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "webserver"
    security_groups = ["launch-wizard-1"]
    tags = {
        Name = var.tags_name
        env = "default"
    }
    availability_zone = "us-west-2a"
    
}

resource "aws_ebs_volume" "webserver_volume" {
    availability_zone = "us-west-2a"
    size              = 2
    type              = "gp3"
    tags = {
        Name = "webserver-volume"
    }
}

resource "aws_volume_attachment" "webserver_volume_attachment" {
    device_name = "/dev/sdh"
    volume_id   = aws_ebs_volume.webserver_volume.id
    instance_id = aws_instance.webserver.id
}


