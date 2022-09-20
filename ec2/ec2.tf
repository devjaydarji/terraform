variable "awsprops" {
    type = map
    default = {
    region = "us-east-2"
    vpc = "vpc-0b90ca8246a0cf94c"  #add as per AWS console
    ami = "ami-092b43193629811af"
    itype  = "t2.micro"
    subnet = "subnet-011541fe09cbb5bfe" #add as p AWS console
    publicip = true
    keyname = "myseckey"
    secgroupname = "task-Sec-Group_2"
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
  }

resource "aws_security_group" "project-iac-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "ec2-instance" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 20
   
  }
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "Rhel"
    Managed = "task"
  }

  depends_on = [ aws_security_group.project-iac-sg ]
}



