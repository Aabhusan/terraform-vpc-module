resource "aws_launch_configuration" "test" {

    name_prefix="test-"
    image_id="${data.aws_ami.amazon_linux.id}"
    instance_type="${var.bastian_instance_type}"
    key_name="${aws_key_pair.bastion.key_name}"
    associate_public_ip_address= false
    enable_monitoring=false
    security_groups="${aws_security_group.test.id}"

    lifecycle{
        create_before_destroy=true
    }
  
}

resource "aws_autoscaling_group" "test" {
    
    name="test-asg"
    min_size=0
    desired_capacity=0
    max_size=1
    health_check_type="EC2"
    launch_configuration="${aws_launch_configuration.test.name}"
    vpc_zone_identifier=["${aws_subnet.private.*.id}"]
}



