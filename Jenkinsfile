pipeline {
    agent any
    
    stages {
        
        /*stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }*/

        stage('Git clone'){
            steps{
                git branch: 'main', url: 'https://github.com/ArsalanSan/netology-dp.git'
            }
        }
        
        stage('Init'){
            steps{
                withCredentials([string(credentialsId: 'YDBKEY', variable: 'KEY'), string(credentialsId: 'YDBSECRET', variable: 'SECRET')]) {
                    sh 'terraform init -backend-config="access_key=$KEY" -backend-config="secret_key=$SECRET"'
                }
            }
        }

        stage('Plan') {
            steps {
                withCredentials([file(credentialsId: 'TFVARS', variable: 'VAR')]) {
                    sh 'terraform plan -out tfplan -var-file=$VAR'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }
        
       stage('Apply'){
            steps{
                sh "terraform apply tfplan"
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}