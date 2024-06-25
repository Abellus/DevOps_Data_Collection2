# Voici quelques suggestions pour améliorer votre Dockerfile:

# Utilisez un tag explicite pour votre image de base
FROM python:3.9-slim as base

# Définissez l'utilisateur par défaut
USER root

# Installez les dépendances système 
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ssh-client \ 
    wget \
    netcat \
    curl \
    locales

# Générez les locales
#RUN locale-gen en_US.UTF-8

# Créez un utilisateur non racine 
#RUN useradd -ms /bin/bash appuser

# Définissez le répertoire de travail
WORKDIR /app

# Copiez juste le code nécessaire
COPY ./requirements.txt ./requirements.txt 
COPY . . 

# Installez les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Changez d'utilisateur
USER appuser

# Exposez le port
EXPOSE 8501

# Définissez l'entrée de commande
ENTRYPOINT ["streamlit","run","Accueil.py"]