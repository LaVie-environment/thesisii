terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
    profile = "gachio"
}



resource "aws_key_pair" "ack-key-pair" {
    key_name   = var.key_pair_name
    public_key = tls_private_key.ack_key.public_key_openssh

    provisioner "local-exec"{
    command = "echo '${tls_private_key.ack_key.private_key_pem}' > ./${var.key_pair_name}.pem"
  }

}

resource "tls_private_key" "ack_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

/*
resource "local_file" "ack-key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "ack-key-pair"
}
*/

resource "aws_instance" "ack-env" {
    ami = "ami-09dd2e08d601bff67"
    instance_type = "t2.micro"
    key_name = aws_key_pair.ack-key-pair.key_name
    vpc_security_group_ids = [aws_security_group.ack-env-wall.id]
    
    tags = {
        Name = "ack-org"
    }
}

resource "aws_security_group" "ack-env-wall" {
    name = "our-wall"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
