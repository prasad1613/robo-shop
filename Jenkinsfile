node {
    def dockerImage = 'sphari/cart'
    def dockercredentialsID = 'docker'
    def filePath  = 'cart-deployment.yaml'
    stage('clone') {
        git branch: 'cart', credentialsID: 'git-hub', url: 'https://github.com/prasad1613/robo-shop.git'
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
    stage('clone') {
        dir('/var/lib/jenkins/workspace/robo-deployment') {
            git branch: 'main', credentialsId: 'git-hub', url: 'https://github.com/prasad1613/robo-deployment.git'
        }
    }
    stage('replace version') {
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        script {
            sh "sed -i 's|sphari/cart:[0-9.]*|${dockerImageTag}|g' ${filePath}"
            //sed -i 's|${dockerImage}:[0-9.]*|${dockerImageTag}|g' ${filePath}
        }    
        }
    }
    stage('push version in github') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        sh "git config --global user.email 'prasads1613@gmail.com'"
        sh "git config --global user.name 'prasad1613'"
        sh "git add ${filePath}"
        sh "git commit -m deployment-file-${dockerImageTag}"
    }
}  
    stage('Push to GitHub') {
     branch = 'main'
     dir('/var/lib/jenkins/workspace/robo-deployment') {
         withCredentials([string(credentialsId: 'git-hub-token', variable: 'GITHUB_TOKEN')]) {
            sh 'git checkout main'
            sh "git pull origin main"
            sh 'git push https://${GITHUB_TOKEN}@github.com/prasad1613/robo-deployment.git main'
            }
}
}

}
