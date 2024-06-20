node {
    def dockerImage = 'sphari/cart'
    def dockercredentialsID = 'dock'
    def filePath  = 'cart-deployment.yaml'
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
        dir('/var/lib/jenkins/workspace/') {
<<<<<<< HEAD
            git credentialsId: 'git-hub', url: 'https://github.com/prasad1613/robo-deployment.git'
=======
            git credentialsId: 'git-hub', url: 'https://github.com/prasad1613/vote.git'
>>>>>>> f677d962ba3af6acfd1c4c89046349e35f8171b2
        }
    }
    stage('replace version') {
        dir('/var/lib/jenkins/workspace/') {
        def dockerImageTag = "${dockerImage}:${env.BUILD_NUMBER}"
        script {
            sh "sed -i 's|sphari/cart:[0-9.]*|${dockerImageTag}|g' ${filePath}"
<<<<<<< HEAD
            //sed -i 's|${dockerImage}:[0-9.]*|${dockerImageTag}|g' ${filePath}

=======
>>>>>>> f677d962ba3af6acfd1c4c89046349e35f8171b2
        }    
        }
    }
    stage('push version in github') {
<<<<<<< HEAD
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        sh "git config --global user.email 'prasads1613@gmail.com'"
        sh "git config --global user.name 'prasad1613'"
        sh "git add ${filePath}"
        sh "git commit -m deployment-file-${dockerImageTag}"
=======
        dir('/var/lib/jenkins/workspace/k8s-deploy-service') {
        sh "git config --global user.email 'prasads1613@gmail.com'"
        sh "git config --global user.name 'prasad1613'"
        sh "git add ${filePath}"
        sh "git commit -m change-in-vote-deployment"
>>>>>>> f677d962ba3af6acfd1c4c89046349e35f8171b2
        sh "git pull origin main"
    }
}  
    stage('push version in github') {
<<<<<<< HEAD
        dir('/var/lib/jenkins/workspace/robo-deployment') {
        def GIT_BRANCH = 'main'
         withcredentials(credentialsID: 'git-hub-token', "${GITHUB-TOKEN}") {
                   sh 'git checkout main'
                   sh 'git push https://prasad1613:${GITHUB-TOKEN}@github.com/prasad1613/robo-deployment.git ${GIT_BRANCH}'
=======
        dir('/var/lib/jenkins/workspace/k8s-deploy-service') {
        def GIT_BRANCH = 'main'
         withcredentials(credentialsID: 'git-hub-token', "${GITHUB-TOKEN}") {
                   sh 'git checkout main'
                   sh 'git push https://prasad1613:${GITHUB-TOKEN}@github.com/username/repository.git ${GIT_BRANCH}'
>>>>>>> f677d962ba3af6acfd1c4c89046349e35f8171b2
         } 
        }
    }

}