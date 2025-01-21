# Usamos la imagen Jenkins LTS como base
FROM jenkins/jenkins:lts

# Instalamos curl, sudo y otras dependencias necesarias
USER root
RUN apt-get update && apt-get install -y curl sudo

# Copiamos el binario de Docker desde la imagen docker:cli
COPY --from=docker:cli /usr/local/bin/docker /usr/local/bin

# Instalamos Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && echo "Docker Compose instalado correctamente: $(docker-compose --version || echo 'Error en instalación')"

RUN usermod -aG root jenkins



# Volvemos al usuario Jenkins
USER jenkins
