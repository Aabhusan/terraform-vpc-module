variable "vpc_region" {
  type    ="string"
  
}
variable "cidr_block" {
  type    ="string"
}
variable "environment" {
  type      ="string"
  default   ="test"
}
variable "availability_zones" {
  type    ="list"

  
}
variable "bastion_instance_type" {
  type    ="string"

  
}
variable "aws_ami" {  
  type    ="map"
  default = {
    
    us-east-1 = "ami-1d4e7a66"
    
  }

  
}






