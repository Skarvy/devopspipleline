provider "aws" {
  region = "us-east-1"
}

# Crear un par de claves para la autenticación SSH
resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key"
  public_key = file("C:/Users/skarv/.ssh/id_rsa.pub") # Cambia si tu llave está en otro lugar
}

# Grupo de seguridad para permitir acceso a los puertos necesarios
resource "aws_security_group" "docker_sg" {
  name        = "docker-sg"
  description = "Security group for Docker services"
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2
resource "aws_instance" "docker_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 en us-east-1
  instance_type = "t2.micro"              # Capa gratuita
  key_name      = aws_key_pair.deployer_key.key_name
  security_groups = [aws_security_group.docker_sg.name]

  user_data = <<-EOT
              #!/bin/bash
              yum update -y

              # Instalar Docker
              yum install -y docker
              systemctl start docker
              systemctl enable docker

              # Instalar Docker Compose
              curl -L "https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose

              # Agregar ec2-user al grupo docker
              usermod -aG docker ec2-user

              # Crear directorio de trabajo y otorgar permisos
              mkdir -p /home/ec2-user/app
              chown -R ec2-user:ec2-user /home/ec2-user/app
              chmod -R 755 /home/ec2-user/app

              # Escribir el archivo docker-compose.yml
              echo "${file("Dockerfile")}" > /home/ec2-user/app/Dockerfile
              echo "${file("docker-compose.yml")}" > /home/ec2-user/app/docker-compose.yml

              sudo usermod -aG docker ec2-user

              # Cambiar al directorio y levantar los contenedores
              cd /home/ec2-user/app
              sudo -u ec2-user docker-compose up -d
EOT

  tags = {
    Name = "docker-server"
  }

}

# Outputs
output "instance_public_ip" {
  value = aws_instance.docker_server.public_ip
}

output "instance_id" {
  value = aws_instance.docker_server.id
}
