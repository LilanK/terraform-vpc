resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.test_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test_sg"
  }
}