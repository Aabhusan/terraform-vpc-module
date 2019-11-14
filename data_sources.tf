data "template_file" "bastion_public_key" {
    template    ="${file("~/.ssh/id_rsa.pub")}"
  
}

/*data "aws_ami" "amazon_linux" {
    most_recent         =true
    owners              = ["self"]
    executable_users    = ["self"]
    

    filter{
        name    = "name"
        values  =["amzn-ami-*-x86_64-gp2"]

    }
    filter{
        name        = "virtulization-type"
        values      =["hvm"]

    }
    filter{
        name        ="owner-alias"
        values      =["amazon"]
    }
} */