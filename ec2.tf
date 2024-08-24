resource "aws_instance" "myec2" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.ssh-sg.id ]
  key_name               = aws_key_pair.app-ssh-key.key_name
  user_data              = file("${path.module}/install.sh")
  tags = {
    "Name" = "App-server"
  }
}

resource "aws_key_pair" "app-ssh-key" {
  key_name   = "app-ssh-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-Key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename = "TFKey"
}