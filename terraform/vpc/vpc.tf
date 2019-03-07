# Define Provider
provider "aws" {
  region     = "${var.aws_region}"
}


# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Terraform-vpc"
  }
}

