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
  stage('check code') {
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
    stage('terraform apply') {
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
    stage('run unit test') {
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
              terraform output --json > TERRAFORM_OUTPUT.json
              /opt/python/3/bin/python3 -m venv .venv
              source .venv/bin/activate
              pip install --upgrade pip
              pip install -r python-dependencies.txt
              python3 -m py.test -v -s --color=yes --junit-xml reports/junit_out.xml ../tests
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
