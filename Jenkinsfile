pipeline {
    agent any
    
    stages {
        
        stage('Clean Workspace') {
            cleanWs()
        }

        stage('Git clone'){
            steps{
                git branch: 'main', url: 'https://github.com/ArsalanSan/netology-dp.git'
            }
        }
        
        stage('Plan') {
            steps {
                withCredentials([file(credentialsId: 'TFVARS', variable: 'VAR')]) {
                    sh 'terraform init'
                    sh 'terraform plan -out tfplan -var-file=$VAR'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }
        
       /* stage('Apply'){
            steps{
                sh "terraform apply tfplan"
            }
        }*/
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}