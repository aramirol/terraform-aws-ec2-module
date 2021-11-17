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

def TEST_DIR='./tests'

pipeline{
//    agent {
//        label 'CCC-WORKER'
//    }

    options {
        ansiColor('xterm')
//        lock resource: 'terraform_landing_network'
    }

    stages {
        stage("Apply Terraform resources on Cloud") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    /opt/terraform/terraform init
                    /opt/terraform/terraform validate
                    /opt/terraform/terraform plan
                    /opt/terraform/terraform apply -auto-approve -parallelism=2
                    """
                }
              }
            }
        }

        stage("Run unit test") {
            steps {
              dir (TEST_DIR) {
                credentialsForTestWrapper {
                    sh """
                    terraform output --json > TERRAFORM_OUTPUT.json
                    /opt/python/3/bin/python3 -m venv .venv
                    source .venv/bin/activate
                    pip install --upgrade pip
                    pip install -r python-dependencies.txt
                    source .venv/bin/activate
                    python3 -m py.test -v -s --color=yes --junit-xml reports/junit_out.xml ../tests
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
              sh "/opt/terraform/terraform destroy -auto-approve -parallelism=2"
           }
             junit allowEmptyResults: true, testResults: 'reports/junit_out.xml'
          }
        }
        cleanup {
            cleanWs()
        }
    }
}