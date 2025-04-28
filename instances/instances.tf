resource "aws_instance" "web" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.sg_web_id]
  associate_public_ip_address = true
  key_name = var.ssh_key_name

  user_data = <<-EOF
    #!/bin/bash
    apt update && apt upgrade -y
    apt install -y ca-certificates curl gnupg lsb-release nginx

    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update -y
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl start docker
    systemctl enable docker

    # Copiando configurações do nginx
    cat > /etc/nginx/sites-available/default <<'NGINX_DEFAULT'
    ${replace(file("${path.module}/../nginx/default.conf"), "$", "$$")}
    NGINX_DEFAULT

    cat > /etc/nginx/conf.d/load-balancer.conf <<'NGINX_LB'
    ${replace(file("${path.module}/../nginx/load-balancer.conf"), "$", "$$")}
    NGINX_LB

    cat > /etc/nginx/conf.d/reverse-proxy.conf <<'NGINX_RP'
    ${replace(file("${path.module}/../nginx/reverse-proxy.conf"), "$", "$$")}
    NGINX_RP

    systemctl restart nginx

    usermod -aG docker ubuntu

    chmod 400 /home/ubuntu/${basename(var.ssh_private_key_path)}
  EOF

  tags = {
    Name = "Web Server"
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

resource "aws_instance" "db" {
  ami                    = "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.sg_db_id]
  key_name = var.ssh_key_name

  user_data = <<-EOF
    #!/bin/bash
    apt update && apt upgrade -y
    apt install -y ca-certificates curl gnupg lsb-release

    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update -y
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    systemctl start docker
    systemctl enable docker

    usermod -aG docker ubuntu
  EOF

  tags = {
    Name = "Database Server"
  }
}

resource "aws_instance" "backend" {
  ami                    = "ami-084568db4383264d4" # Ubuntu 22.04
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.sg_backend_id]
  key_name = var.ssh_key_name

  user_data = <<-EOF
    #!/bin/bash
    apt update && apt upgrade -y
    apt install -y ca-certificates curl gnupg lsb-release docker.io

    systemctl start docker
    systemctl enable docker

    usermod -aG docker ubuntu
  EOF

  tags = {
    Name = "Backend Server"
  }
}