#Voici quelques modifications pour prendre en compte l'exécution sur Windows au lieu de Linux:

# Image de base de Python pour Windows au lieu de Linux
FROM mcr.microsoft.com/python:3.9-windowsservercore-ltsc2022

# Installation des dépendances via PowerShell au lieu d'apt
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201; \
    Install-Module -Name DockerMsftProvider -Repository PSGallery -Force; \
    Install-Package -Name Docker -ProviderName DockerMsftProvider

# Copie du code sans spécification du répertoire de destination 
COPY . .

# Exécution de pip via PowerShell
RUN pip install --no-cache-dir -r requirements.txt

# Définition de l'entrée de commande 
CMD ["python", "Accueil.py"] 

# Pas de changement d'utilisateur sous Windows

# Exposition du port HTTP
EXPOSE 8000