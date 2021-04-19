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
variable "tags"{
  default     = {}
  description = "Tags del modulo"
  type        = map(string)
}
variable "cidr_block" {
  type        = string
  default     = "172.0.0.0/16"
  description = "CIDR Block que tendra la VPC"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  default     = {"172.0.1.0/26","172.0.2.0/26"}
  description = "Bloque CIDRS para subnet publica dentro de la red"
}
variable "private_subnet_cidrs" {
  type        = list(string)
  default     = {"172.0.3.0/26","172.0.4.0/26"}
  description = "Bloque CIDRS para subnet privada dentro de la red"
}
variable "vpc_azs" {
  type        = list(string)
  default     = {"us-west-1a", "us-west-1b"}
  description = "Lista de zonas de disponibilidad asignadas dentro de la red"
}
