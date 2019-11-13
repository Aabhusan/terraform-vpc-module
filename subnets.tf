#creating the public subnet
resource "aws_subnet" "public" {
    count="${length(var.availability_zones)}"
    vpc_id="${aws_vpc.main.id}"
    cidr_block="${cidrsubnet(var.cidr_block, 8, count.index)}" 
    availability_zone="${element(var.availability_zones, count.index)}" 
    map_public_ip_on_launch=true

    tags{
        "name"= "public subnet - ${element(var.availability_zones, count.index)}"
    }

}

#creating the private subnet
resource "aws_subnet" "private" {
    count="${length(var.availability_zones)}"
    vpc_id="${aws_vpc.main.id}"
    cidr_block="${cidrsubnet(var.cidr_block, 8, count.index)}" 
    availability_zone="${element(var.availability_zones, count.index+length(var.availability_zones))}" 
    map_public_ip_on_launch=false

    tags{
        "name"= "private subnet - ${element(var.availability_zones, count.index)}"
    }

}
#creatinf the elastic ip address
resource "aws_eip" "nat" {
    count="${length(var.availability_zones)}"
    vpc = true
}

#creating the nat gateway
resource "aws_nat_gateway" "main" {
    count = "${length(var.availability_zones)}"
    subnet_id="${element(aws_subnet.public.*.id,count.index)}"
    allocation_id="${element(aws_eip.nat.*.id, count.index)}"

    tags{
        "name" = "NAT - ${element(var.availability_zones, count.index)}"
    }
  
}

