# Define the public subnet
resource "aws_subnet" "public-subnet" {
  count = "${length(var.public_subnet_cidr)}"
  vpc_id = "${aws_vpc.default.id}"
  #cidr_block = "${var.public_subnet_cidr}"
  cidr_block = "${element(values(var.public_subnet_cidr), count.index)}"
  #availability_zone = "ap-southeast-1a"
  availability_zone = "${element(keys(var.public_subnet_cidr), count.index)}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  count = "${length(var.private_subnet_cidr)}"
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${element(values(var.private_subnet_cidr), count.index)}"
  availability_zone = "${element(keys(var.private_subnet_cidr), count.index)}"
  #map_public_ip_on_launch = "true"
  tags {
    #Name = "Private Subnet ${substr("${element(keys(var.private_subnet_cidr), count.index)}", length("${element(keys(var.private_subnet_cidr), count.index)}") -1, 1)}"
    Name = "Private Subnet ${count.index + 1}"
  }



}
