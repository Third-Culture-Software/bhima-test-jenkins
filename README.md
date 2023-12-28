# bhima-test-jenkins
Jenkins and related Docker files for the BHIMA end-to-end test server

These directions assume Ubuntu LTS, but should be easily adapted to any Debian-based distro.

Note that this test server  runs Jenkins in a docker container, so it requires Docker.

1. Update your installation
   `sudo apt update; sudo apt upgrade -y`
2. Install Docker
   - See https://docs.docker.com/engine/install/ubuntu/
   - The 'install using the apt repository' option seems to work smoothly
3. Create a 'bhima' user (and enable sudo access for this user)
   - `sudo adduser --uid 1000 --gid 1000 bhima`
   - `sudo echo "bhima ALL=(ALL) ALL" | /etc/sudoers.d/bhima`
4. Create a 'jenkins' user for the systemd startup
   - `useradd --shell /sbin/nlogin jenkins`
   - `usermod -a -G docker jenkins`
5. Log in as `bhima` and clone this repo
   - `git clone https://github.com/IMA-WorldHealth/bhima-test-jenkins.git jenkins`
6. Create a build directory
   - `cd jenkins`
   - `mkdir build`
7.  Verify that the Jenkins WAR file version is up to date in the Dockerfile
    - check https://www.jenkins.io/download/ for the latest WAR file version
    - Verify that this is the version in the Dockerfile (update locally if necessary)
8.  Create the docker image
    - `./build_image`  (enter password to use sudo; this should take a few minutes)
9. Create a local directory for a Docker volume to store the configuration
    - `mkdir /var/jenkins`
    - `chown -R bhima.bhima /var/jenkins`
10. Install jenkins/docker service (as root)
    - copy 'jenkins-docker.service' to /etc/systemd/system/
    - `systemctl daemon-reload`
    - `systemctl enable jenkns-docker.service`
    - `systemctl start jenkins-docker.service`
11.  Verify that Jenkins is running and start the  initial startup process
    - Check for good start:  `systemctl status jenkins-docker.service`
    - Log into the local jenkins website:  http://<hostname>:8080
        (where 'hostname' could be 'localhost' or the hostname of the Jenkins server
