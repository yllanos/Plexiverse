NAS_IP=10.0.0.10
USER=yllanos
PASS=091527
IP_OF_UBUNTU_SERVER=10.0.0.8

sudo add-apt-repository ppa:stebbins/handbrake-releases
sudo apt update
sudo apt install git curl ftpd openssh-server gdisk xfsprogs ansible handbrake-cli ffmpeg #mergerfs
sudo cp docker-compose.yml /opt
sudo curl -sSL https://get.docker.com | sh
wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/test/amd64/docker-ce_18.03.0~ce~rc1-0~ubuntu_amd64.deb
sudo dpkg -i docker-ce_18.03.0~ce~rc1-0~ubuntu_amd64.deb
sudo usermod -aG docker $USER ##Dar privilegios al usuario predeterminado de S.O. hacia Docker. Hacer logout de la terminal
sudo docker run hello-world ##Prueba Docker
sudo apt install docker-compose ##
sudo useradd dockeruser
#DOCKERUSERID=`id -u dockeruser` 
DOCKERUSERID=`id -u $USER`
echo "PUID=$DOCKERUSERID" | sudo tee --append /etc/environment
echo "PUID=$DOCKERUSERID" | sudo tee --append ~/.bash_profile
echo "PGID=$DOCKERUSERID" | sudo tee --append /etc/environment
echo "PGID=$DOCKERUSERID" | sudo tee --append ~/.bash_profile
echo "alias dcrun='docker-compose -f /opt/docker-compose.yml up -d ' " | sudo tee --append ~/.bash_profile
echo "alias dclogs='docker-compose -f /opt/docker-compose.yml logs -tf --tail="50" ' " | sudo tee --append ~/.bash_profile
echo "alias startdocker='sudo systemctl start docker ' " | sudo tee --append ~/.bash_profile
source ~/.bash_profile
sudo systemctl enable docker # sudo systemctl disable docker ##Para arrancar Docker con el S.O.
sudo apt-get install nfs-common samba ##Instalar cliente NFS
sudo apt-get install cifs-utils ##Por si aca
sudo mkdir -p /mnt/tv ##Crea directorio local para Series
#sudo chown dockeruser:users /mnt/tv
sudo mkdir -p /mnt/docu ##Crea directorio local para Documentales
#sudo chown dockeruser:users /mnt/docu
sudo mkdir -p /mnt/movie ##Crea directorio local para Documentales
#sudo chown dockeruser:users /mnt/movie
sudo mkdir -p /mnt/downloads ##Crea directorio local para Descargas
sudo mkdir -p /mnt/music ##Crea directorio local para Música
sudo mkdir -p /mnt/concerts ##Crea directorio local para Música
sudo mkdir -p /mnt/transcode ##Crea directorio local transcodificar
sudo chmod -R 777 /mnt/transcode
#sudo chown dockeruser:users /mnt/music
#sudo mount -v -rw $NAS_IP:/volume1/Series /mnt/tv ##Monta remote share de Series
#sudo mount -v -rw $NAS_IP:/volume1/Docu /mnt/docu ##Monta remote share de Series
#sudo mount -v -rw $NAS_IP:/volume1/Peliculas /mnt/movie ##Monta remote share de Peliculas
#sudo mount -v -rw $NAS_IP:/volume1/Downloads /mnt/downloads ##Monta remote share de Descargas
#sudo mount -v -rw $NAS_IP:/volume1/Music /mnt/music ##Monta remote share de Descargas
echo
cat /etc/fstab
echo
#echo "$NAS_IP:/volume1/Series /mnt/tv nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee --append /etc/fstab ##Monta el share de series al arranque
echo "//$NAS_IP/Series /mnt/tv cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
#echo "$NAS_IP:/volume1/Docu /mnt/docu nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee --append /etc/fstab ##Monta el share de documentales al arranque 
echo "//$NAS_IP/Docu /mnt/docu cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
#echo "$NAS_IP:/volume1/Peliculas /mnt/movie nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee --append /etc/fstab ##Monta el share de documentales al arranque 
echo "//$NAS_IP/Peliculas /mnt/movie cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
#echo "$NAS_IP:/volume1/Downloads /mnt/downloads nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee --append /etc/fstab ##Monta el share de documentales al arranque 
echo "//$NAS_IP/Downloads /mnt/downloads cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
#echo "$NAS_IP:/volume1/Music /mnt/music nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee --append /etc/fstab ##Monta el share de musica al arranque 
echo "//$NAS_IP/Music /mnt/music cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
echo "//$NAS_IP/Conciertos /mnt/concerts cifs user=$USER,pass=$PASS 0 0" | sudo tee --append /etc/fstab 
cat /etc/fstab
echo 
sudo mkdir -p /transcode
sudo chown -R $USER /transcode 

echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee --append /etc/apt/sources.list
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
sudo apt-get update
sudo apt-get install webmin ##Ir a https://$IP_OF_UBUNTU_SERVER:10000


#startdocker
#dcrun

#docker-compose -f /opt/docker-compose.yml up -d
#docker-compose -f /opt/docker-compose.yml logs
http://$IP_OF_UBUNTU_SERVER:32400/web ##Plex
http://$IP_OF_UBUNTU_SERVER:8989 ##Sonarr
http://$IP_OF_UBUNTU_SERVER:7878 ##Radarr
http://$IP_OF_UBUNTU_SERVER:9117 ##Jackett
http://$IP_OF_UBUNTU_SERVER:9091 ##Transmission
http://$IP_OF_UBUNTU_SERVER:6789 ##nzbget
http://$IP_OF_UBUNTU_SERVER:8181 ##tautulli

##Radarr
#Bot Token: 408309504:AAFUOfDifiOu_E8J2c37YfKMSZag75rgRFw
#Chat ID: -4644062

##Sonarr
#Bot Token: 408309504:AAFUOfDifiOu_E8J2c37YfKMSZag75rgRFw
#Chat ID: 20622277

##deluge
#http://<ip>:8112
