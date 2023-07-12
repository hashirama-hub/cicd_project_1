pipeline{
    agent any
    environment {
        DOCKERHUB_USER = "tuanlinhdocker"
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
    }
}