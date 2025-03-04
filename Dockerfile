FROM jenkins/jenkins:lts-jdk17

# Get the latest Jenkins WAR file version
ARG vnum
RUN echo **** UPDATING TO JENKINS WAR file version $vnum

USER root

# Install stuff
RUN apt update
RUN apt upgrade -y
RUN apt install -y sudo openssh-server git rsync wget

# Update Jenkins Java war file
RUN wget http://updates.jenkins-ci.org/download/war/$vnum/jenkins.war
RUN mv jenkins.war /usr/share/jenkins/
RUN chown jenkins:root /usr/share/jenkins/jenkins.war

USER jenkins
