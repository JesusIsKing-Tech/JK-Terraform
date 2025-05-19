resource "aws_instance" "db" {
  ami                     = "ami-084568db4383264d4"
  instance_type           = "t2.micro"
  subnet_id               = var.private_subnet_id
  vpc_security_group_ids  = [var.sg_db_id]
  key_name                = var.ssh_key_name
  user_data = file("${path.module}/scripts/docker.sh")

  tags = {
    Name = "Database Server"
  }
}