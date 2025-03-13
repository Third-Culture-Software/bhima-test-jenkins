FROM jenkins/jenkins:lts-jdk17

# Get the latest Jenkins WAR file version
ARG vnum
RUN echo **** UPDATING TO JENKINS WAR file version $vnum

USER root

# Update deps, install packages.
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  sudo \
  openssh-server \
  git \
  rsync \
  wget \
  ca-certificates


# Update Jenkins Java war file
RUN wget --no-verbose https://updates.jenkins.io/download/war/${vnum}/jenkins.war && \
  mv jenkins.war /usr/share/jenkins/ && \
  chown jenkins:jenkins /usr/share/jenkins/jenkins.war && \
  # Clean up to reduce image size
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Print Jenkins version for verification
  echo "*** Successfully updated to Jenkins WAR version ${vnum} ***"

# set restricted permissions for the war file
RUN chmod 644 /usr/share/jenkins/jenkins.war

USER jenkins
