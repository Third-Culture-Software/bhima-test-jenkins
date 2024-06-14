# bhima-test-jenkins
Jenkins and related Docker files for the BHIMA end-to-end test server

These directions assume Ubuntu LTS, but should be easily adapted to any Debian-based distro.

Note that this test server  runs Jenkins in a docker container, so it requires Docker.

## Installation

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
    - Verify that this is the version in the Dockerfile (update locally if necessary; 
      see section below for update process).
8.  Create the docker image
    - `./build_image`  (enter password to use sudo; this should take a few minutes)
    - NOTE: you may need to make a copy of this build script with updated paths
      for your installation.
9. Create a local directory for a Docker volume to store the configuration
    - `mkdir /var/jenkins`
    - `chown -R bhima.bhima /var/jenkins`
10. Install jenkins/docker service (as root)
    - copy 'jenkins-docker.service' to /etc/systemd/system/
    - `systemctl daemon-reload`
    - `systemctl enable jenkns-docker.service`
    - `systemctl start jenkins-docker.service`
11. Verify that Jenkins is running and start the  initial startup process)
     - Check for good start:  `systemctl status jenkins-docker.service`
     - Log into the local jenkins website:  `http://<hostname>:8080` (where 'hostname' could be 'localhost' or the hostname of the Jenkins server)
     - Start the Jenkins configuration process in the browser.
12. Update all Jenkins plugins (and restart Jenkins)
13. Install Jenkins 'Blue Ocean' plugin
14. Set up the Jenkins build agents.   See https://github.com/IMA-WorldHealth/bhima-test-e2e for details.
    - Disable build agents on the Jenkins server
       - Set `Dashboard > Manage Jenkins > System > System > # of executors` to 0 (and [Save])
15. Set up the 'Run BHIMA tests' pipeline with Blue Ocean (with button on the main left menu bar).
    - See [Tutorial with Blue Ocean](https://www.youtube.com/watch?v=f4idgaq2VqA)
    - Choose `GitHub` project
    - When prompted, create your own Github token and insert it.
      Note that is this will usually be for your own Github account that has necessary rights to the BHIMA repository.
    - Select the 'IMA-WorldHealth' organization
    - Select the 'bhima-test-jenkins' repository
    - Confirm to create the pipeline.  Note that this will run the pipeline immediately.
    - Exit Blue Ocean to get to the "Classic" view.
    - Note: If you do not already have the build agents working, you may want to abort it and
      temporarily disable it using the "Disable Multibranch Pipeline" button on the
      pipeline page (eg, http://<jenkins-server>/job/bhima-test-jenkins).
16. Once build agentws are available, re-enable the pipleline and click on the "Build Now" button.  
    You should start seeing the run in progress on the job page
    (eg, http://<jenkins-server>/job/bhima-test-jenkins/job/main/).

## Update the Jenkins WAR file
At some point, when you access the Jenkins web site, you may notice that Jenkins complains 
that the version of Jenkins is out of date.  To update Jenkins, follow this procedure:
1. Log into the BHIMA jenkins server (via ssh).
2. Go to the Jenkins build directory (containing this file) on the server with `cd`
3. Run: `./build_image`  (it will probably ask for your `sudo` password)
   - Note: this will update the Jenkins Docker image with the latest version of the 
           Jenkins WAR file.  If you want to run some other version, edit the 'Dockerfile'
           and comment out the 'RUN wget' line with 'latest' in it and uncomment the 
           previous RUN wget' line and insert the desired Jenkins WAR version number.
           Then run 'build_image'.

4. Once it completes rebuilding the Docker image with the updated Jenkins WAR file, restart
   the jenkins docker image.  It would be best to wait until the current build is 
   complete (eg, check the website or wait until 45 minutes after the hour).

    `sudo systemctl restart jenkins-docker.service`

   This will take a few moments to complete.
7. Verify that Jenkins was updated:  Refresh your Jenkins web session and verify that the 
   warning message is gone.
