resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_port.id]
  tags = {
    Name = "bastion"
  }
}
