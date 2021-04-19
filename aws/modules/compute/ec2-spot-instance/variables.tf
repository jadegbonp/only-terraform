# Entradas del Stack
variable "environment" {
  type        = string
  default     = "dev"
  description = "Tipo de ambiente"
}
variable "region" {
  type        = string
  default     = "us-west-1"
  description = "Region dominante"
}
variable "application" {
  type        = string
  default     = "acme"
  description = "Nombre de solución"
}
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
variable "ami" {
  type        = string
  description = "ID de AMI que tendra la instancia"
}
variable "tags"{
  default     = {}
  description = "Tags del modulo"
  type        = map(string)
}
