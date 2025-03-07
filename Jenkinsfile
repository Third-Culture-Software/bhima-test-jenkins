pipeline {
  agent any
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
      mail(to: 'jmcameron@gmail.com,BMbayo@imaworldhealth.org',
      subject: 'BHIMA Tests Failure',
         from: 'bhima@jmcameron.net', body: "Details: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, \nBuild: ${env.BUILD_URL} \nConsole Output: ${env.BUILD_URL}console")
    }

  }
  triggers {
    cron('''0 0,2,4,6,8,10,12,14,16,18,20,22 * * *
  ''')
  }
}
