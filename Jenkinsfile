// JENKINSFILE

// Defining AWS Credentials
def credentialsForTestWrapper(block) {
    // it's a module repo, we only use dev credentials for developing and testing
    // once code has been merged to master, use dev credentials to finish the unit testing
    withCredentials([
        [
            $class: 'ConjurSecretApplianceCredentialsBinding',
            credentialsId: "cpiactoolchain",
            sPath: "projects/iactcprd/prod/variables/TERRA_EXAMPLE_AK",
            // variable: 'TERRA_EXAMPLE_AK'
            variable: 'AWS_ACCESS_KEY_ID'
        ],
        [
            $class: 'ConjurSecretApplianceCredentialsBinding',
            credentialsId: "cpiactoolchain",
            sPath: "projects/iactcprd/prod/variables/TERRA_EXAMPLE_SK",
            // variable: 'TERRA_EXAMPLE_SK'
            variable: 'AWS_SECRET_ACCESS_KEY'
        ],
    ]) {
        block.call()
    }
}

// Set working directory
def TEST_DIR='./tests'

// Init pipeline
pipeline{
    agent {
        label 'CCC-WORKER'
    }

    options {
        ansiColor('xterm')
        lock resource: 'terraform_landing_network'
    }

    stages {
        stage("Validate Terraform code") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    terraform init
                    terraform validate
                    terraform plan
                    """
                }
              }
            }
        }

        stage("Apply Terraform resources on Cloud") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh "terraform apply -auto-approve -parallelism=2"
                }
              }
            }
        }

//        stage("Run unit test with InSpec") {
//            steps {
//              dir (TEST_DIR) {
//                credentialsForTestWrapper {
//                    sh """
//                    rm -f ./inspec/inspec.lock
//                    rm -f ./inspec/files/terraform_output.json
//                    terraform output --json > ./inspec/files/terraform_output.json
//                    inspec exec inspec -t aws:// --chef-license accept-silent --reporter cli junit:./inspec/reports/junits_out.xml
//                    """
//                }
//              }
//            }
//        }

        stage("Run unit test with PyTest") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    terraform output --json > ./pytest/terraform_output.json
                    cd pytest
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r python-dependencies.txt
                    python3 -m pytest -v -s --color=yes -o junit_family=xunit2 --junitxml=reports/junits_out.xml ec2tests.py
                    """
                }
              }
            }
        }

    }

    post {
        always {
          dir (TEST_DIR) {
           credentialsForTestWrapper {
              sh "terraform destroy -auto-approve -parallelism=2"
           }
             junit allowEmptyResults: true, testResults: 'pytest/reports/junits_out.xml'
          }
        }
        cleanup {
            cleanWs()
        }
    }
}