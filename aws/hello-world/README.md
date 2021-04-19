## Configuraciones Requeridas
Configurar credenciales para Terraform de AWS.

Variables de Ambiente:

```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
```
Configurar CLI de AWS:

```
aws configure
```

### Entradas
Son las entradas que son definidas en la plantilla:

| Variable | Valor | Descripción |
| -- | -- | -- |
| instance_type | t3.micro (default) | Tipo de Instancia que se creara |
| spot_price | 0.03 (default) | Valor de solicitud de instancia Spot |

### Ejecución
Se debe ejecutar los siguientes comandos:
```
terraform init
terraform plan
terrafom apply --auto-approve
```
### Diagrama

<img src="./assets/hello-world.png" width="200"/>

