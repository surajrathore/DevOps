# Define the public subnet
resource "aws_subnet" "public-subnet" {
  #count = "${length(var.public_subnet_cidr)}"
  vpc_id = "${aws_vpc.default.id}"
  #cidr_block = "${var.public_subnet_cidr}"
  cidr_block = "${element(values(var.public_subnet_cidr_temp), 0)}"
  #availability_zone = "ap-southeast-1a"
  availability_zone = "${element(keys(var.public_subnet_cidr_temp), 0)}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "Public Subnet A"
    #Name = "Public Subnet ${substr("${element(keys(var.public_subnet_cidr), count.index)}", length("${element(keys(var.public_subnet_cidr), count.index)}") -1, 1)}"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "ap-southeast-1a"

  tags {
    Name = "Private Subnet A"
  }
}
