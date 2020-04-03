resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = data.aws_availability_zones.azs.names[0]
  subnet_id              = aws_subnet.demo[0].id
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  key_name               = aws_key_pair.mykeypair.key_name
  associate_public_ip_address = true
  user_data              = file("install_jenkins")

  tags = {
    Name        = "Jenkins-demo"
    Environment = "sandbox"
  }
}
