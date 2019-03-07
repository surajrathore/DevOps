# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Terraform VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Public Subnet*"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  count = "${length(var.public_subnet_cidr)}"
  #subnet_id = "${aws_subnet.public-subnet.1.id}"
  subnet_id = "${element(data.aws_subnet_ids.public.ids,count.index)}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

