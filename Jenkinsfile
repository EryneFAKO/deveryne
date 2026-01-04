pipeline {
    agent any
    tools {
        maven "Maven"  // Nom par défaut dans Jenkins, on vérifiera
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Test') {
            steps {
                sh 'mvn clean verify'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t deveryne-app:latest .'
            }
        }
        stage('Deploy to VM Deploy') {
            steps {
                sshagent(['deploy-ssh-key']) {
                    sh '''
                        docker save deveryne-app:latest | ssh -o StrictHostKeyChecking=no vagrant@192.168.56.11 docker load
                        ssh -o StrictHostKeyChecking=no vagrant@192.168.56.11 "
                            docker stop deveryne-app || true
                            docker rm deveryne-app || true
                            docker run -d --name deveryne-app -p 8080:8080 deveryne-app:latest
                        "
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Déploiement réussi ! Accède à l’app ici : http://192.168.56.11:8080/hello'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}