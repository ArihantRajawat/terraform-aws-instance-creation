resource "aws_key_pair" "terraform-pub-key" {
         key_name = "terra-key"
         public_key = file("/home/ubuntu/.ssh/terra-key.pub")
}
resource "aws_default_vpc" "default-vpc" {
}

resource "aws_security_group" "allow-ssh" {
         name = "allow_ssh"
         description = "allow ssh inbound rule"
#using default vpc
vpc_id = aws_default_vpc.default-vpc.id
ingress {

#we should allow incoming and outgoing
#TCP packets
from_port = 22
to_port = 22
protocol = "tcp"
#allow all traffic
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "allow_ssh"
}

}


resource "aws_instance" "ec2-vpc-setup" {
         key_name = aws_key_pair.terraform-pub-key.key_name
         ami = var.ec2-ubuntu-ami
         instance_type = "t3.micro"
         security_groups = [aws_security_group.allow-ssh.name]

   tags = {
   Name = "secured_instance"
}
}