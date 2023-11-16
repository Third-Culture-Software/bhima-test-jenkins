FROM jenkins/jenkins:lts-jdk17

USER root

# Install stuff
RUN apt update && apt upgrade -y
RUN apt install -y sudo openssh-server git

USER jenkins
