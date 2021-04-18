# Se especifica el proveedor de servicios AWS
provider "aws" {
  region = "us-west-1"
}
# Consulta de amis para la region del usuario
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

# Solicita una spot instance con $0.03 USD
resource "aws_spot_instance_request" "cheap_instance" {
  ami           = element(data.aws_ami_ids.ami.ids, 0)
  spot_price    = var.spot_price
  instance_type = var.instance_type

  tags = {
    Name = "CheapInstance"
  }
}

