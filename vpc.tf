#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr

  tags = map(
    "Environment", "sandbox",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "demo" {
  count = 2

  availability_zone = data.aws_availability_zones.azs.names[count.index]
#  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "30.0.${count.index}.0/24"
#  cidr_block        = "30.0.3.0/24"
  vpc_id            = aws_vpc.demo.id

  tags = map(
    "Environment", "sandbox",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Environment = "sandbox"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }

}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo.*.id[count.index]
#  subnet_id      = aws_subnet.demo.id
  route_table_id = aws_route_table.demo.id

}
