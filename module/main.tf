resource "aws_security_group" "global-sg-2021" {
  name        = var.sgname
  description = "Allow SSH HTTP HTTPS"
  #Creating a security Group
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }

  tags = {
    Name = var.sgname
  }
}
#Creating a EC2 Instance
resource "aws_instance" "webserver" {
  depends_on    = [aws_vpc.dev-vpc]
  ami           = var.amiid
  instance_type = var.machinetype
  key_name      = var.keyname

  tags = {
    Name = var.mytag
  }
}
#Creating a VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.vpcname
  }
}
#subnet:Attach to VPC
resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availablity-zone
  tags = {
    Name = var.subname
  }
}
# Internet Gateway: attach to VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = var.IGname
  }
}
# Route table: attach Internet Gateway
resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = var.rtname
  }
}

# Route table association with dev subnets
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-rt.id
}
