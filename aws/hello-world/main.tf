# Se especifica el proveedor de servicios AWS
provider "aws" {
  region = "us-west-1"
}
/*variables*/
locals {
    vars = "${tomap({
        instance_type = "t3.micro"
        spot_price = "0.03"
    })
    }"
}

/*Consulta de amis para la region del usuario*/
data "aws_ami_ids" "ami" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
}

/*Uso de modulo que contiene variables globales*/
module "global_variables"{
   source          = "../modules/global_variables/common-tags"
}

/*Uso del modulo general de ec2-spot-instance*/
module "ec2_spot_instance"{
  source          = "../modules/compute/ec2-spot-instance"
  # Entradas del modulo
  environment     = lookup(module.global_variables.tags_commons, "environment")
  region          = lookup(module.global_variables.tags_commons, "region")
  application     = lookup(module.global_variables.tags_commons, "application")
  instance_type   = lookup(local.vars, "instance_type")
  spot_price      = lookup(local.vars, "spot_price")
  ami             = element(data.aws_ami_ids.ami.ids, 0)
  tags            = module.global_variables.tags_commons
}
