resource "aws_instance" "web" {
  ami                     = "ami-084568db4383264d4"
  instance_type           = "t2.micro"
  subnet_id               = var.public_subnet_id
  vpc_security_group_ids  = [var.sg_web_id]
  associate_public_ip_address = true
  key_name                = var.ssh_key_name

  user_data = <<-EOF
    #!/bin/bash
    ${file("${path.module}/scripts/docker.sh")}
    ${file("${path.module}/scripts/nginx.sh")}
    chmod 400 /home/ubuntu/${basename(var.ssh_private_key_path)}
  EOF

  tags = {
    Name = "Web Server (Bastion)"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = var.ssh_private_key_path
    destination = "/home/ubuntu/${basename(var.ssh_private_key_path)}"
  }
}