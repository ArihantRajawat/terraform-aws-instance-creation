provider "aws" {
         region = "eu-north-1"
}


resource "aws_s3_bucket" "bucket-creation" {
         bucket = "arihant-bucket-list-india"

}


resource "aws_instance" "new-one" {
         ami = var.ec2-ubuntu-ami
         instance_type = "t3.micro"
         tags = {
         Name = "terraform-first-instance"

}
}