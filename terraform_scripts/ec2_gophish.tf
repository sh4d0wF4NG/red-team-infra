resource "aws_instance" "gophish_instance" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_port.id]
  user_data              = <<EOF
#!/bin/bash
cd /tmp
apt install -y git sqlite3 libsqlite3-dev gcc net-tools
wget https://go.dev/dl/go1.19.13.linux-amd64.tar.gz -O /opt/go1.19.13.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf /opt/go1.19.13.linux-amd64.tar.gz
git clone https://github.com/gophish/gophish.git /root/gophish
  EOF
  tags = {
    Name = "gophish_instance"
  }
}
