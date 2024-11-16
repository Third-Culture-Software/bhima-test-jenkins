FROM jenkins/jenkins:lts-jdk17

USER root

# Install stuff
RUN apt update
RUN apt upgrade -y
RUN apt install -y sudo openssh-server git rsync wget

# Update Jenkins Java war file
RUN wget http://updates.jenkins-ci.org/download/war/2.485/jenkins.war
# RUN wget http://updates.jenkins-ci.org/latest/jenkins.war
RUN mv jenkins.war /usr/share/jenkins/
RUN chown jenkins:root /usr/share/jenkins/jenkins.war

USER jenkins
