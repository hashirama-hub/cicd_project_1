pipeline{
    agent any
    environment {
        DOCKERHUB_USERNAME = "tuanlinhdocker"
        APP_NAME = "cicd_project_1"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}" + "/" + "${IMAGE_TAG}"
        REGISTRY_CREDS = 'dockerhub'

    }

    stages{
        stage('Clean Workspace'){
            steps{
                script{
                    cleanWs()
                }
            }      
        }
        stage('Check SCM'){
            steps{
                git credentialsId: 'github',
                url : 'https://github.com/hashirama-hub/cicd_project_1.git',
                branch: 'master'
            }
        }
        stage ('Build Docker Image'){
            steps{
                script{
                    docker_image = docker.build "${IMAGE_NAME}"
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('', REGISTRY_CREDS){
                        docker_image.push("${BUILD_NUMBER}")
                        docker_image.push("laster")
                    }
                }
            }
        }
        stage('Delete Docker Images'){
            steps {
                sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker rmi ${IMAGE_NAME}:latest"
            }
        }
        stage('Updating Kubernetes deployment file'){
            steps {
                sh "cat deployment.yml"
                sh "sed -i 's/${APP_NAME}.*/${APP_NAME}:${IMAGE_TAG}/g' deployment.yml"
                sh "cat deployment.yml"
            }
        }
        stage('Push the changed deployment file to Git'){
            steps {
                script{
                    sh """
                    git config --global user.name "tuanlinh"
                    git config --global user.email "tuanlinh060300@gmail.com"
                    git add deployment.yml
                    git commit -m 'Updated the deployment file' """
                    withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'pass', usernameVariable: 'user')]) {
                        sh "git push http://$user:$pass@github.com/hashirama-hub/cicd_project_1.git master"
                    }
                }
            }
        
    }
}
}