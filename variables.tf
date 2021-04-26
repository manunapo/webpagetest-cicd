variable "profile" {
  default = "personal"
}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
     default = "us-east-1a"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "instance_count" {
  default = "1"
}
variable "private_key" {
  default = "private/webpagetest-sshkey"
}
variable "public_key" {
  default = "private/webpagetest-sshkey.pub"
}
variable "ansible_user" {
  default = "ec2-user"
}
variable "ami" {
  default = "ami-0742b4e673072066f"
}
variable "vpc_CIDR_block" {
    default = "10.0.0.0/16"
}
variable "subnet_CIDR_block" {
    default = "10.0.1.0/24"
}
variable "destination_CIDR_block" {
    default = "0.0.0.0/0"
}

#Be aware here! restringe more the access
variable "ingress_CIDR_block" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egress_CIDR_block" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "map_public_IP" {
    default = true
}