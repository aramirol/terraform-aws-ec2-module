// Jenkinsfile
String credentialsId = 'aws_test'

def TEST_DIR='./tests'

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }
  // Run terraform init, validate and plan
  stage('Terraform Init & Plan') {
    node {
      dir (TEST_DIR) {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh """
            terraform init
            terraform validate
            terraform plan
            """
          }
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'main') {

    // Run terraform apply
    stage('Terraform Apply') {
      node {
        dir (TEST_DIR) {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform apply -auto-approve'
            }
          }
        }
      }
    }

    // Run terraform otuputs
    stage('Run Unit Tests') {
      node {
        dir (TEST_DIR) {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh """
              terraform output --json > ./verify/files/terraform.json
              inspec exec verify --chef-license accept-silent --reporter cli junit:verify/files/testresults.xml -t aws://
              """
            }
          }
        }
      }
    }

    // Run terraform destroy
    stage('destroy') {
      node {
        dir (TEST_DIR) {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform destroy -auto-approve'
            }
          }
        }
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}
