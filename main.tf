provider "aws" {
  region = "us-east-1" # Change region as needed
}

resource "aws_instance" "example" {
  ami           = "ami-00ca32bbc84273381" # Amazon Linux 2 AMI in us-east-1 (update per region)
  instance_type = "t2.micro"

tags = {
    Name = "Terraform-Server"
  }
}
