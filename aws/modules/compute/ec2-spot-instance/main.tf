# Solicita una spot instance con $0.03 USD
resource "aws_spot_instance_request" "spot_instance" {
  ami           = var.ami
  spot_price    = var.spot_price
  instance_type = var.instance_type

  #tags
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "${lower(var.application)}-${lower(var.environment)}-${lower(var.region)}-spot-instance"
    }
  )
}
