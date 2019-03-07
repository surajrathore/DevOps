# Define EC2 Instance
resource "aws_instance" "public" {
  #count = "${length(var.public_subnet_cidr)}"
  #count = "${length(data.aws_subnet_ids.public.ids)}"
  count = 4
  ami           = "${var.ami}"
  instance_type = "t2.small"
  #subnet_id = "${aws_subnet.public-subnet.id}"
  subnet_id = "${element(data.aws_subnet_ids.public.ids,count.index)}"
  user_data = <<-EOF
	        #!/bin/sh
		yum install -y httpd
		systemctl start httpd
		chkonfig httpd on
		echo "<html><h1> Hello from RATHORE </h2></html>" > /var/www/html/index.html
              EOF
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "Terraform-Public-instance-${count.index + 1}"
  }
  key_name = "${aws_key_pair.default.id}"
}

output "public_ip" {
  value = "${aws_instance.public.*.public_ip}"
}


# Define EC2 Instance
resource "aws_instance" "private" {
  #count = "${length(data.aws_subnet_ids.private.ids)}"
  count = 6
  ami           = "${var.ami}"
  instance_type = "t2.small"
  subnet_id = "${element(data.aws_subnet_ids.private.ids,count.index)}"
  user_data = "${file("install.sh")}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "Terraform-Private-Instance-${count.index + 1}"
  }
  key_name = "${aws_key_pair.default.id}"
}

output "private_ip" {
  value = "${aws_instance.private.*.private_ip}"
}
