# Entradas del Stack
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Tipo de instancia"
}
variable "spot_price" {
  type        = string
  default     = "0.03"
  description = "Valor en USD de solicitud de Spot Instance"
}
