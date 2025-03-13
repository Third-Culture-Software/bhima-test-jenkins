pipeline {
  agent any
	
  options {
      timeout(time: 4, unit: 'HOURS')   // timeout on whole pipeline job
  }
	
  stages {
    stage('Start tests') {
      steps {
        echo 'Starting'
      }
    }

    stage('Run remote Bhima tests') {
      steps {
        sh '/home/jenkins/builds/run_tests'
      }
    }

  }
  post {
    always {
      archiveArtifacts(artifacts: 'results.zip, results/summary.txt, results/environment.txt', fingerprint: true)
      junit(skipPublishingChecks: true, testResults: 'results/*.xml')
    }

    changed {
      mail(to: 'jmcameron@gmail.com',
      subject: 'BHIMA Tests Regression',
         from: 'bhima@jmcameron.net',
	 body: "Details: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, \nBuild: ${env.BUILD_URL} \nConsole Output: ${env.BUILD_URL}console \nChanges: ${env.RUN_CHANGES_DISPLAY_URL}")
    }

    failure {
      mail(to: 'jmcameron@gmail.com,BMbayo@imaworldhealth.org,jonathanwniles@gmail.com'
      subject: 'BHIMA Tests Failure',
         from: 'bhima@jmcameron.net', body: "Details: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, \nBuild: ${env.BUILD_URL} \nConsole Output: ${env.BUILD_URL}console")
    }

  }
  triggers {
    cron('''0 0,4,8,12,16,20 * * *
  ''')
  }
}
