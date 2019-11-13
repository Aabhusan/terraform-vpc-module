variable "vpc_region" {
  type="string"
  
}
variable "cidr_block" {
  type="string"
}
variable "environment" {
  type="string"
  default="test"
}
variable "availability_zones" {
  type="list"

  
}
variable "bastian_instance_type" {
  type="string"

  
}





