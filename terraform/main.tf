resource "aws_instance" "server" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.mysg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = var.private_key
    timeout = "4m"
  }
  tags = {
    "name" = "nodeapp_server"
  }
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-profile"
  role = "ec2-ecr-role"
}

resource "aws_security_group" "mysg" {
  egress = [ 
    {
        cidr_blocks = ["0.0.0.0/0"]
        description = ""
        from_port = 0
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "-1"
        security_groups = []
        self = false
        to_port = 0
    }
   ]
   ingress = [ 
    {
        cidr_blocks = ["0.0.0.0/0", ]
        description = ""
        from_port = 22
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "tcp"
        security_groups = []
        self = false
        to_port = 22
    },
    {
        cidr_blocks = ["0.0.0.0/0", ]
        description = ""
        from_port = 80
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "tcp"
        security_groups = []
        self = false
        to_port = 80
    }
    ]
}

resource "aws_key_pair" "mykey" {
  key_name = var.key_name
  public_key = var.public_key
}


output "instance_public_ip" {
  value = aws_instance.server.public_ip
  sensitive = true
}