resource "aws_vpc" "main" {   #creating the aws_vpc
  cidr_block    ="${var.cidr_block}"

  tags ={
      "Name"    ="main VPC"
  }
}

#creating the internet gateway
resource "aws_internet_gateway" "main" {
    vpc_id      ="${aws_vpc.main.id}"

    tags={
        "Name"  ="main internet gateway"
    }
  
}



