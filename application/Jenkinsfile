import groovy.transform.Field
@Field def lTAG = null

node {
    stage('Git clone image'){
        //git branch: 'main', url: 'https://github.com/ArsalanSan/dp-app.git'
        git branch: 'main', url: 'https://github.com/ArsalanSan/netology-dp.git'
    }
    
    withCredentials([string(credentialsId: 'DOCKER_HUB_TOKEN', variable: 'TOKEN')]){
        sh "docker login -u arsalansan -p $TOKEN"
    }
    
    stage('Get tag'){
        script{
            lTAG=sh(returnStdout: true, script: "git describe --tags --abbrev=0").trim()
        }
    }
    
    stage("Docker build"){
        sh "cd application && docker build -t arsalansan/dp-app:latest ."
    }

    stage("Set tag and push image"){
        sh "docker push  arsalansan/dp-app:latest"
        sh "docker tag arsalansan/dp-app:latest arsalansan/dp-app:${lTAG}"
        sh "docker push arsalansan/dp-app:${lTAG}"
    }
    
    stage('Deploy application'){
        kubeconfig(caCertificate:'', credentialsId: 'KUBECONFIG', serverUrl: 'https://lbnodes:6443'){
            sh "kubectl -n dp-app set image deployments/dp-app dp-app=arsalansan/dp-app:${lTAG}"
        }
    }
}