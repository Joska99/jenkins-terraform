pipeline {
    agent any
    tools {
    terraform 'tf'
    }
    environment {
        TF_HOME = tool('tf')
        TF_IN_AUTOMATION = 'true'
        PATH = "$TF_HOME:$PATH"
    }

    stages {
      stage('Terraform Init') {
        steps {
          withCredentials([azureServicePrincipal(
                    credentialsId: 'SA_TF',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
          )]) {
          sh '''
                        echo "Initialising Terraform"
                        rm -rf .terraform
                        . ./init.sh
                        terraform init -upgrade -reconfigure
                        cat variables.tf
                        '''
          }
        }
      }
      stage('Terraform Plan') {
        steps {
          withCredentials([azureServicePrincipal(
                    credentialsId: 'SA_TF',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
          )]) {
            sh '''
                        echo "Creating Terraform Plan"
                        terraform  plan -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
                        '''
          }
        }
      }
      stage('Terraform Apply') {
        steps {
          withCredentials([azureServicePrincipal(
                    credentialsId: 'SA_TF',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
          )]) {
          sh '''
                        echo "Applying the plan"
                        terraform apply -auto-approve -var "client_id=$ARM_CLIENT_ID" -var "client_secret=$ARM_CLIENT_SECRET" -var "subscription_id=$ARM_SUBSCRIPTION_ID" -var "tenant_id=$ARM_TENANT_ID"
                        ls -lah
                        '''
          }
        }
      }
    }
}
