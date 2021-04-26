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
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjRj0J/yTaEyQX1EpHf0hnY7j2ml8yl66+e6shLT+J077EcM0JlUw9H8mo1BzwP4avGCfjEYL4cszihAGC62KlgsV4i3UTnsPD24NfUOaUoJkCIWl/ddxPwDSCEWWX5hQ6rLDS9bGBvXf3xpUTjYYqVFVpFsSAqmujXeRiRhhisbXGLJrWKb8HRHLHSsCcPtE4pDMdeROwm9+sqjQN3g8MhEnR03uCVz5nUmnSn+KfV9LfAn91OQ8rhLhtE84qCemOu+POiSuU1Qr4MtQ8rygLhDUNEaMYmAuTKU0m6YLxKk50Jgmxf7+mYd2lnF/0M9fEqZx5z90qMW+UR9krxd4M6ZNgdxr/Cli2C4uiemRvGHEldyFU6mtPyAOP13b7ZMFeF+2/yVr0deKmcYuNm4JOUhT4g6023VfXYanCz0Q14fAbEt0ngOAhP2dlAzDYbENnZE8ldxZLFerNoy8C8QeTnsDQieRN521kxgwrLdlV/12ZQJHvJZiXstPB1OB62bs= mnapoli@192.168.1.20"
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