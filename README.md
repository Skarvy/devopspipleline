
# Proyecto de Infraestructura con Terraform

Este repositorio contiene la configuración necesaria para crear y gestionar la infraestructura utilizando Terraform. A través de los archivos de configuración de Terraform, puedes levantar, modificar y destruir la infraestructura en la nube de forma automatizada.

## Requisitos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu máquina:

- [Terraform](https://www.terraform.io/downloads.html) - Para gestionar la infraestructura como código.
- [AWS CLI](https://aws.amazon.com/cli/) (si estás usando AWS) - Para interactuar con los servicios de AWS desde la línea de comandos.
- [Git](https://git-scm.com/) - Para clonar y gestionar el repositorio.

## Configuración

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/tu-usuario/terraform.git
   cd terraform
Configura tus credenciales de AWS:

Si estás utilizando AWS, asegúrate de tener configuradas tus credenciales de AWS utilizando el siguiente comando:

bash
Copiar
Editar
aws configure
Inicializa el proyecto de Terraform:

Terraform requiere ser inicializado para descargar los proveedores y módulos necesarios. Ejecuta el siguiente comando dentro del directorio del proyecto:

bash
Copiar
Editar
terraform init
Revisa la infraestructura que se creará:

Antes de aplicar los cambios, puedes revisar lo que se va a crear o modificar ejecutando:

bash
Copiar
Editar
terraform plan
Aplica la configuración de Terraform:

Para aplicar los cambios y levantar la infraestructura definida en los archivos de configuración de Terraform, ejecuta:

bash
Copiar
Editar
terraform apply
Terraform te pedirá confirmación antes de proceder. Ingresa yes para continuar.

Verifica la infraestructura:
Por consola nos va a aparecer 
Outputs:
instance_id = "i-051efcee7f1a4bbba"
instance_public_ip = "3.84.163.15"

debemos acceder al ip publico desde una consola y nuestra key



Destrucción de la Infraestructura
Si deseas destruir la infraestructura creada por Terraform, ejecuta el siguiente comando:

bash
Copiar
Editar
terraform destroy
Terraform te pedirá confirmación antes de proceder. Ingresa yes para continuar.