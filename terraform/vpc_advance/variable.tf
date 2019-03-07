variable "aws_region" {
  description = "Region for the VPC"
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  #default = "10.10.1.0/24"
  default = {
    ap-southeast-1a = "10.10.1.0/24"
    ap-southeast-1b = "10.10.2.0/24"
    ap-southeast-1c = "10.10.3.0/24"
	}
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  #default = "10.10.10.0/24"
  default = {
    ap-southeast-1a = "10.10.10.0/24"
    ap-southeast-1b = "10.10.20.0/24"
    ap-southeast-1c = "10.10.30.0/24"
        }
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-04677bdaa3c2b6e24"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/centos/.ssh/id_rsa.pub"
}
