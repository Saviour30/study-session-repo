resource "aws_vpc" "vida" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "${var.tag}-VPC"
  }
}

#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vida.id
  cidr_block = var.pub_cidr
  tags = {
    Name = "${var.tag}-Public Subnet"
  }
}

#private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vida.id
  cidr_block = var.prv_cidr
  tags = {
    Name = "${var.tag}-Private Subnet"
  }
}

# internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vida.id

  tags = {
    Name = "Internet GW"
  }
}

#public rt
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.vida.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

#private rt
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.vida.id

  route {
    cidr_block = var.prv_cidr
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "Private Route Table"
  }

/*resource "aws_route_table_association" "prv_RT" {
 subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_RT.id

}
*/
#EIP
  resource "aws_eip" "Elastic_ip" {
    vpc = true
   # depends_on = [aws_internet_gateway.internet_gw]
  }

# Nat gateway
  resource "aws_nat_gateway" "nat_gw" {
   connectivity_type = "private"
    subnet_id     = aws_subnet.private_subnet.id

    }
}
  
