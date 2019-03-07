# Define EC2 Instance
resource "aws_instance" "public" {
  count = 2
  ami           = "${var.ami}"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.public-subnet.id}"
  user_data = <<-EOF
	        #!/bin/sh
		yum install -y httpd
		systemctl start httpd
		chkonfig httpd on
		echo "<html><h1> Hello from RATHORE </h2></html>" > /var/www/html/index.html
              EOF
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "terraform-instance-${count.index}"
  }
  key_name = "${aws_key_pair.default.id}"
}

output "public_ip" {
  value = "${aws_instance.public.*.public_ip}"
}


# Define EC2 Instance
resource "aws_instance" "private" {
  ami           = "${var.ami}"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.private-subnet.id}"
  user_data = "${file("install.sh")}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags {
    Name = "terraform-instance"
  }
  key_name = "${aws_key_pair.default.id}"
}

output "private_ip" {
  value = "${aws_instance.private.private_ip}"
}
