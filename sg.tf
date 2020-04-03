#Jenkins SG

resource "aws_security_group" "jenkins" {
  name        = "Jenkins-sg"
  description = "Allow 8080 port"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "HTTP_8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["125.16.91.5/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP_22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["125.16.91.5/32", "3.82.211.83/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow_8080_22"
    Environment = "sandbox"
  }
}
