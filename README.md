# Proyecto de Infraestructura con Terraform

Este repositorio contiene la configuración necesaria para crear y gestionar la infraestructura utilizando **Terraform**. A través de los archivos de configuración de Terraform, puedes automatizar la creación, modificación y destrucción de la infraestructura en la nube.

## Requisitos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu máquina:

- **[Terraform](https://www.terraform.io/downloads.html)**: Para gestionar la infraestructura como código.
- **[AWS CLI](https://aws.amazon.com/cli/)** (si usas AWS): Para interactuar con los servicios de AWS desde la línea de comandos.
- **[Git](https://git-scm.com/)**: Para clonar y gestionar el repositorio.

## Configuración

### 1. Clonar el repositorio

Primero, clona el repositorio y accede al directorio del proyecto:

```bash
git clone https://github.com/Skarvy/devopspipleline
cd terraformdeploy
```
### 2. Configuración de credenciales AWS
Si estás utilizando AWS, asegúrate de tener configuradas tus credenciales ejecutando:

```bash
aws configure
```
Este comando te pedirá el Access Key ID, Secret Access Key, la región y el formato de salida.

### 3. Inicializar el proyecto de Terraform
Terraform requiere ser inicializado para descargar los proveedores y módulos necesarios. Ejecútalo dentro del directorio del proyecto:

```bash
terraform init
```
### 4. Revisión de la infraestructura a crear
Antes de aplicar los cambios, revisa lo que se va a crear o modificar ejecutando:

```bash
terraform plan
```
Este comando te mostrará los cambios que Terraform realizará en la infraestructura.

### 5. Aplicar la configuración de Terraform
Para aplicar los cambios y crear la infraestructura definida en los archivos de configuración de Terraform, ejecuta:

```bash
terraform apply
```
Terraform te pedirá confirmación antes de proceder. Ingresa yes para continuar.

### 6. Verificación de la infraestructura
Al finalizar la ejecución de terraform apply, Terraform te mostrará la salida con información relevante, como:


Outputs:
  instance_id = "i-051efcee7f1a4bbba"
  instance_public_ip = "3.84.163.15"
Accede a la instancia EC2 utilizando el IP público mostrado en la salida, junto con la clave privada configurada previamente para tu instancia.

### 7. Configuración del entorno Docker
Conéctate a tu instancia EC2 a través de SSH:

```bash
ssh -i /ruta/a/tu/clave.pem ec2-user@<IP_publica>
```
Luego, añade el usuario ec2-user al grupo Docker para poder ejecutar comandos de Docker sin necesidad de sudo:

```bash
sudo usermod -aG docker ec2-user
```
Reinicia la conexión SSH para que los cambios tengan efecto.

### 8. Levantar los contenedores Docker
Una vez dentro de la instancia, navega al directorio de la aplicación y levanta los contenedores utilizando Docker Compose:

```bash
cd app
docker-compose up -d
```
Esto levantará los contenedores de Jenkins y SonarQube.

### 9. Acceder a la interfaz web
Para acceder a la interfaz web de Jenkins y SonarQube, abre un navegador y entra a la dirección IP pública de tu instancia EC2, agregando el puerto correspondiente (por ejemplo, 8080 para Jenkins):

```bash
http://<IP_publica>:8080
```
Aquí podrás configurar tu pipeline de CI/CD.

Destrucción de la Infraestructura
Si deseas destruir la infraestructura creada por Terraform, ejecuta el siguiente comando:

```bash
terraform destroy
```
Terraform te pedirá confirmación antes de proceder. Ingresa yes para continuar y destruir la infraestructura.