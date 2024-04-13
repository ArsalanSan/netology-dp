pipeline {
    agent{
        kubernetes { 
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:24.0.9-dind
    securityContext:
      privileged: true
'''     }
        
    } 
    stages{
        stage('Git clone'){
            steps{
                git branch: 'main', url: 'https://github.com/ArsalanSan/dp-app.git'
            }
        }
        
        stage('Build and push'){
            steps{
                container('docker') {
                    withCredentials([string(credentialsId: 'DOCKER_HUB_TOKEN', variable: 'TOKEN')]) {
                        sh "docker login -u arsalansan -p $TOKEN"
                    }
                    sh 'git config --global --add safe.directory "*"'
                    sh 'docker build -t arsalansan/dp-app:$(git describe --tags --abbrev=0) .' 
                    sh 'docker push  arsalansan/dp-app:$(git describe --tags --abbrev=0)'
                }
            }
        }
    }
}