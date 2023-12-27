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
   - `sudo adduser bhima`
   - `sudo echo "bhima ALL=(ALL) ALL" | /etc/sudoers.d/bhima`
4. Log in as `bhima` and clone this repo
   - `git clone https://github.com/IMA-WorldHealth/bhima-test-jenkins.git jenkins`
5. Create a build directory
   - `cd jenkins`
   - `mkdir build`
6.  Verify that the Jenkins WAR file version is up to date in the Dockerfile
   - check https://www.jenkins.io/download/ for the latest WAR file version
   - Verify that this is the version in the Dockerfile (update locally if necessary)
7.  Create the docker image
   - `./build_image`  (enter password to use sudo)
8. Install jenkins/docker service
   - ? 
