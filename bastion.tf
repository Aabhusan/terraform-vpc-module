
resource "aws_key_pair" "bastion" {
    key_name        ="bastion-key"
    public_key      ="${data.template_file.bastion_public_key.rendered}"

}
resource "aws_launch_configuration" "bastion" {
    name_prefix                     ="bastion-"
    image_id                        ="${lookup(var.aws_ami, var.vpc_region)}"
    instance_type                   ="${var.bastion_instance_type}"
    key_name                        ="${aws_key_pair.bastion.key_name}"
    associate_public_ip_address     =true
    enable_monitoring               =false
    security_groups                 =["${aws_security_group.bastion.id}"]

    lifecycle{
        create_before_destroy=true

    }
}

resource "aws_autoscaling_group" "bastion" {
    name                        ="bastion-asg"
    min_size                    =0
    desired_capacity            =1
    max_size                    =1
    health_check_type           ="EC2"
    launch_configuration        ="${aws_launch_configuration.bastion.name}"
    vpc_zone_identifier         ="${aws_subnet.public.*.id}"

    tags=[
        {
            key                     ="Name"
            value                   ="bastion"
            propagate_at_launch     =true
        },
    ]   
}

resource "aws_security_group" "bastion" {
  name          ="Bastion-SG"
  description   ="allow all the inbound traffic"
  vpc_id        ="${aws_vpc.main.id}"
  
  lifecycle{
        create_before_destroy=true

    }
}
resource "aws_security_group_rule" "allow_all_ssh" {
    type                ="ingress"
    from_port           = 22
    to_port             = 22
    protocol            ="tcp"
    cidr_blocks         =["0.0.0.0/0"]
    security_group_id   ="${aws_security_group.bastion.id}"
  
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type                    ="egress"
    from_port               =0
    to_port                 = 0
    protocol                ="-1"
    cidr_blocks             =["0.0.0.0/0"]
    security_group_id       ="${aws_security_group.bastion.id}"
  
  
}



