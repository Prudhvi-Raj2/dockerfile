resource "aws_instance" "this"{
    ami                    = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    instance_type          = "t3.micro"
root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }
  user_data = file("${path.module}/install_docker.sh")
  user_data_replace_on_change = true   # <‑‑ auto‑recreate if script change
/*   connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }
  provisioner "remote-exec" {
  inline = [ 
    "sudo growpart /dev/nvme0n1 4",
    "sudo lvextend -l +50%FREE /dev/RootVG/rootVol",
    "sudo lvextend -l +50%FREE /dev/RootVG/varVol",
    "sudo xfs_growfs /",
    "sudo xfs_growfs /var",
    "sudo dnf update -y",
    "sudo dnf install -y dnf-utils",
    "sudo dnf -y install dnf-plugins-core",
    "sudo sleep 10",
    "sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo",
    "sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
    "sudo sleep 10",
    "sudo systemctl enable --now docker",
    "sudo usermod -aG docker ec2-user"
    ]    
  } */
  tags = {
      Name = "docker"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

/*     ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    } */
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
  
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "security_tls"
  }
}
