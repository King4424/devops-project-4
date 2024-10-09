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

**---> pom.xml:**
```
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>Sonarqube-job</artifactId>
  <version>1.0</version>
</project>
```

### **6. Install Maven in the jenkins-server**
```
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip
```

**---> we need to install unzip utility tool to unzip maven file**
```
apt install unzip -y
```

**---> unzip maven-package-3.9.9 file**

### **7. Go to Jenkins Dashboard, Create New Job- devops-project-4 -> select pipeline and create job.**

**---> go inside the job now we have to write one scripted pipeline to do CI/CD complete automation for this project.**

**---> scripted pipeline always start's with 'node' block.**

**---> first we have to write code to get Git code into jenkins**
```
node {
    stage('GetCode') {
        git branch: 'main', url: 'https://github.com/King4424/devops-project-4.git'
    }
```

**---> now we have to write code for 'mvn package' this will package our application code**


**---> Go to manage jenkins -> tools -> maven installations**

--> Name = apache-maven-3.9.9

--> select version = 3.9.9

--> apply & save

**---> Go to job -> configure -> scripted pipeline -> pipeline syntax**

---> select: tool:use a tool from a predefined tool installation,  tool type: select maven, generate script and copy it and past in the code.

```
node {
    stage('GetCode') {
        git branch: 'main', url: 'https://github.com/King4424/devops-project-4.git'
    }
    stage('mvn package') {
        def mvnHome = tool name: 'apache-maven-3.9.9', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean install"
    }
```

**---> apply and save**

**---> Build**

### 8. The next step is to write code for Docker image build**
```
node {
    stage('GetCode') {
        git branch: 'main', url: 'https://github.com/King4424/devops-project-4.git'
    }
    stage('mvn package') {
        def mvnHome = tool name: 'apache-maven-3.9.9', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean install"
    }
    stage('buid image') {
        sh 'docker image build -t vaibhavkhairnar/dockernewimage:latest .'
    }
```

**---> apply and save**

**---> but before going to build on jenkins server and on docker server we have to give permission's to user's to docker.sock files**
```
# on jenkins-server
chown jenkins:docker /var/run/docker:sock
```

```
# on docker-host-server
chown ubuntu:docker /var/run/docker.sock
```

**---> now go to jenkins job and build**

**---> go to jenkins server and check whether image is created or not.**

###

