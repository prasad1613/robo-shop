node {
    def dockerImage = 'sphari/mysql'
    def dockercredentialsID = 'docker'
    def filePath  = 'cart-deployment.yaml'
    stage('create') {
        script {
            sh 'mkdir -p /var/lib/jenkins/workspace/robo_shop_mysql'
        }
    }
    stage('clone') {
     dir('/var/lib/jenkins/workspace/robo_shop_mysql') {
        git branch: 'mysql', credentialsID: 'git-hub', url: 'https://github.com/prasad1613/robo-shop.git'
    }
    }
    stage('docker build') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        def customImage = docker.build(dockerImageTag)
    }
    stage('docker push') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        docker.withRegistry('', dockercredentialsID) {
        docker.image(dockerImageTag).push()
        }
    }
    stage('remove image') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        script {
            sh "docker rmi -f ${dockerImageTag}"
        }
    }
    // stage('git pull deploy repo') {
    //     script {
    //      dir('/var/lib/jenkins/workspace/vote') {
    //         sh 'git pull origin main'
    //     }
    // }
    // }
    stage('replace version') {
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        script {
            sh "sed -i 's|sphari/mysql:[0-9.]*|${dockerImageTag}|g' ${filePath}"
        }    
        }
    }
    stage('push version in github') {
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        sh "git config --global user.email 'prasads1613@gmail.com'"
        sh "git config --global user.name 'prasad1613'"
        sh "git add ${filePath}"
        sh "git commit -m change-in-mysql-deployment"
        sh "git pull origin main"
    }
}  
    stage('Push to GitHub') {
     branch = 'main'
     dir('/var/lib/jenkins/workspace/k8s-deploy-service') {
         withCredentials([string(credentialsId: 'git-hub-token', variable: 'GITHUB_TOKEN')]) {
            sh 'git checkout main'
            sh "git pull origin main"
            sh 'git push https://${GITHUB_TOKEN}@github.com/prasad1613/k8s-deploy-service.git main'
            }
}
}

}
