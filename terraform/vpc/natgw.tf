# Define EIP
resource "aws_eip" "NAT" {
	vpc = true
  
    tags {
    Name = "NAT EIP"
  }
}

## Define the NAT Gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.NAT.id}"
  subnet_id     = "${aws_subnet.public-subnet.id}"

  tags = {
    Name = "Terraform NAT"
  }
}


# Define the route table
resource "aws_route_table" "web-private-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-private-rt" {
  subnet_id = "${aws_subnet.private-subnet.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}
