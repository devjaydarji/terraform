provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}
#variable "subnet_prefix" {
 # description = "cidr block for the subnet"

#}



resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-2a"


}


resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-2a"

  
  }
 resource "aws_subnet" "subnet-4" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-2a"

   
  }
  resource "aws_subnet" "subnet-3" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.1.5.0/24"
  availability_zone = "us-east-2a"

  
}


