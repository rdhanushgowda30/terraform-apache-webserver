#create a VPC 
resource "aws_vpc" "main"{
  cidr_block = "10.0.0.0/16"
  tags={
    name="terraform-vpc"
  }
}
# subnet creation
resource "aws_subnet" "main"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags ={
    name = "terraform-subnet"
  }
}
#internet gateway
resource "aws_internet_gateway" "gw"{
  vpc_id = aws_vpc.main.id
  tags = {
    name="terraform-igw"
  }
} 
#route-table
resource "aws_route_table" "rt"{
  vpc_id = aws_vpc.main.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags={
    name="terraform-rt"
  }
}
#route-table-association
resource "aws_route_table_association" "a"{
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}
#security grp
resource "aws_security_group" "apache_sg"{
  vpc_id = aws_vpc.main.id
  name= "apache_sg"
  description = "allow http and ssh inbound traffic"
  
  ingress{
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    name = "apache-sg"
  }
}
	
#ec2 instance
resource "aws_instance" "apache-server"{
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  key_name = "newkey"
 
  user_data = <<-EOF
     #!/bin/bash
     apt update -y
     apt install apache2 -y
     systemctl start apache2
     systemctl enable apache2
     echo "<h1>Hello from Terraform Apache Server</h1>" | sudo tee /var/www/html/index.html
     EOF
  tags={
    name = "terraform-apache"
  }
}
