![svg xmlns=httpwww w3 org2000svg x=0px y=0px width=100 height=100 viewBox=0 0 48 48 path fill=#424242 d=M44,24c0,11 045-8 955,20-20,20S4,35 045,4,24S12 955,4,24,4S44,12 955,44,24zpathpath fill=#fff (3)](https://github.com/user-attachments/assets/81ae6dd6-fbcc-4630-871d-a92bbe9d8e00)
# AIM:
## *Deploying application on remote server in a differnt region on a docker-container using Jenkins Scripted Pipeline with the help of Manven and Docker.*

# STEPS:

### **1. Launch 2 servers**

**---> Jenkins-server - t2.medium - ubuntu - mumbai region**

**---> Docker-Host-server - t2.micro - ubuntu - California region**

### **2. Install Jenkins on Jenkins-server**

**---> follow steps to install Jenkins from jenkins website ( Download Jenkins )**

**---> start Jenkins and enable Jenkins**
```
systemctl start jenkins
systemctl enable jenkins
```

**---> after installation connect with browser and configure**

**---> Install 1. ssh, 2. publish-over-ssh, 3. ssh-agent  Plugins and restart.**


### **3. Install Docker on Docker-server**

**---> start docker & enable docker**

**---> also log-in to docker-host**
```
docker login
```
### **4. On Jenkins-server install docker & start service for docker and also login to docker hub**

### **5. Create one repository on GitHub and write a dockerfile into it & also write on pom.xml file**

**---> Dockerfile:**
```
FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get install -y apache2 curl
RUN apt-get install -y zip
RUN apt-get install -y unzip
COPY hightech.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip hightech.zip
RUN cp -rvf hightech-html/* .
RUN rm -rf hightech hightech.zip
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
EXPOSE 80
```

**---> Pom.xml:**
```

