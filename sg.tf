resource "aws_security_group" "ssh-sg" {
  name        = "allow_ssh_access"
  description = "allow_ssh_access"

  ingress {
    description = "allow_ssh_access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.140.116.145/32", "18.206.107.24/29"]
  }
}