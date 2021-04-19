## EC2 Spot Instance
Modulo que declara los recursos necesarios para implementar infraestructura asociada a instancia Spot. La cual tiene la particularidad de ser solicitada mediante una puja de dinero.

### Entradas
Son las entradas que son definidas en la plantilla:

| Variable | Valor Default | Descripción |
| -- | -- | -- |
| environment | env | Tipo de Ambiente |
| region | us-west-1 | Region de dominante de implementación |
| application | acme | Nombre de la aplicación o sistema que se implementará |
| instance_type | t3.micro | Tipo de Instancia que se creara |
| spot_price | 0.03 | Valor de solicitud de instancia Spot |
| ami | - | Identificación del AMI que se desea utilizar para la instancia |
| tags | {}  | Mapa con tags generales para relacionar en cada recurso |


### Salidas
Son las salidas que se generarán al finalizar la ejecución de la plantilla.

| Variable | Descripción |
| -- | -- |
| instance_public_ip | IP publica de la instancia Spot |
| instance_public_dns | DNS publico de la instancia Spot |











