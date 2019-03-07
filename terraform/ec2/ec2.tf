provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "example" {
  subnet_id = "subnet-2158ed6d"
  ami           = "ami-02ea48e2703b0aa8e"
  instance_type = "t2.micro"
  #security_groups = [ "sg-2be74141" ]
  tags {
        Name = "HelloWorld"
    }
}
