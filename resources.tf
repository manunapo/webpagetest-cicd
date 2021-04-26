resource "random_pet" "name" {}

resource "aws_vpc" "webpagetest-vpc" {
    cidr_block              = var.vpc_CIDR_block
    enable_dns_support      = "true" #gives you an internal domain name
    enable_dns_hostnames    = "true" #gives you an internal host name
    enable_classiclink      = "false"   
    instance_tenancy        = "default"
    tags = {
        Name = "WebPageTest VPC"
    }
}

resource "aws_subnet" "webpagetest-vpc-subnet" {
    vpc_id                  = aws_vpc.webpagetest-vpc.id
    cidr_block              = var.subnet_CIDR_block
    map_public_ip_on_launch = var.map_public_IP 
    availability_zone       = var.availability_zone
    tags = {
        Name = "WebPageTest VPC Subnet"
    }
}

resource "aws_internet_gateway" "webpagetest-igw" {
    vpc_id = aws_vpc.webpagetest-vpc.id
}

resource "aws_route_table" "webpagetest-public-crt" {
    vpc_id = aws_vpc.webpagetest-vpc.id
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.webpagetest-igw.id
    }
}

resource "aws_route_table_association" "webpagetest-crta-public-subnet"{
    subnet_id       = aws_subnet.webpagetest-vpc-subnet.id
    route_table_id  = aws_route_table.webpagetest-public-crt.id
}

resource "aws_security_group" "webpagetest-sg" {
    name        = "${random_pet.name.id}-sg"
    description = "Allow inbound SSH and HTTP"
    vpc_id      = aws_vpc.webpagetest-vpc.id
    ingress {
        description = "inbound ssh"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "inbound http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "WebPageTest SG"
    }
}

resource "aws_key_pair" "webpagetest-sshkey" {
    key_name    = var.private_key
    public_key  = "${file("${var.public_key}")}"
}

resource "aws_instance" "webpagetest-server" {
    ami                     = "ami-0742b4e673072066f"
    instance_type           = "t2.micro"
    key_name                = aws_key_pair.webpagetest-sshkey.key_name
    subnet_id               = aws_subnet.webpagetest-vpc-subnet.id
    vpc_security_group_ids  = [ aws_security_group.webpagetest-sg.id ]
    tags = {
        Name = "webpagetest-server-${random_pet.name.id}"
    }
}
resource "aws_instance" "webpagetest-agent" {
    ami                     = "ami-0742b4e673072066f"
    instance_type           = "t2.micro"
    key_name                = aws_key_pair.webpagetest-sshkey.key_name
    subnet_id               = aws_subnet.webpagetest-vpc-subnet.id
    vpc_security_group_ids  = [ aws_security_group.webpagetest-sg.id ]
    tags = {
        Name = "webpagetest-agent-${random_pet.name.id}"
    }
}