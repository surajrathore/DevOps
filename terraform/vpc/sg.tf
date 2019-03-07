#
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 80
}

# Define Security Group
resource "aws_security_group" "instance" {
  name = "terraform-sg"

  vpc_id="${aws_vpc.default.id}"  

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }


  tags {
    Name = "Terraform-SG"
  }

}

