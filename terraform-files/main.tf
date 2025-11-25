resource "aws_instance" "ansible" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = "yadav"
  user_data              = file("ansible.sh")
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  //subnet_id               = "subnet-077471d3c705ea769"
  tags = {
    Name = "ansible"
  }
}



resource "aws_instance" "jenkins_master" {
  ami                    = var.ami_id
  instance_type          = "t2.small"
  key_name               = "yadav"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]

  tags = {
    Name = "jenkins-master"
  }


}

resource "aws_instance" "jenkins_slave" {
  ami                    = var.ami_id
  instance_type          = "t2.medium"
  key_name               = "yadav"
  user_data              = file("slave.sh")
  vpc_security_group_ids = [aws_security_group.demo-sg.id]

  tags = {
    Name = "jenkins-slave"
  }

}


resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"


  dynamic "ingress" {
    for_each = var.ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "taxi-SG"

  }
}
