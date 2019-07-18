provider "aws" {

        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region = "us-west-2"

}

resource "aws_security_group" "default" {

        name = "vm_securitygroup"

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 8090
                to_port = 8090
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}


resource "aws_instance" "web" {

        ami = "${var.ami}"
        instance_type = "t2.micro"
        key_name = "${var.key_name}"
        vpc_security_group_ids = ["${aws_security_group.default.id}"]

         provisioner "file" {
                source = "/var/mysqldata/init.zip"
                destination = "/tmp/data_storage.zip"
        }

        provisioner "remote-exec" {
                inline = [
                "sudo apt install unzip",
                ]
        }

        provisioner "remote-exec" {
                inline = [
                "unzip /tmp/data_storage.zip",
                ]
        }

        connection {
                user = "ubuntu"
                private_key="${file("/home/devopsinfra/.ssh/terraform.pem")}"
        }
        tags = {
               Name = "Gireesh"
        }
}

output "ip" {
        value = "${aws_instance.web.public_ip}"
}
