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
  subnet_id     = "${aws_subnet.public-subnet.0.id}"

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

data "aws_subnet_ids" "private" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Private Subnet*"
  }
}

# Assign the route table to the private Subnet
resource "aws_route_table_association" "web-private-rt" {
  count = "${length(var.private_subnet_cidr)}"
  subnet_id = "${element(data.aws_subnet_ids.private.ids,count.index)}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}
