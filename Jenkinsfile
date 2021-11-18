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
  // Run terraform init
  stage('init') {
    node {
      dir (TEST_DIR) {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh 'terraform init'
          }
        }
      }
    }
  }

  // Run terraform plan
  stage('plan') {
    node {
      dir (TEST_DIR) {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            sh 'terraform plan'     
          }   
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'main') {

    // Run terraform apply
    stage('apply') {
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

    // Run terraform show
    stage('show') {
      node {
        dir (TEST_DIR) {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: credentialsId,
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform show'
            }
          }
        }
      }
    }

    // Run terraform show
    stage('Run unit tests') {
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
              python -m pytest -v -s --color=yes -o junit_family=xunit2 --junitxml=test-reports/junit.xml boto_mod.py
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