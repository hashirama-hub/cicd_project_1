pipeline{

    agent any
    environment{
        DOCKERHUB_USERNAME = "tuanlinhdocker"
        APP_NAME = "cicd_project"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}" + "/" + "${APP_NAME}"
        REGISTRY_CREPS = 'dockerhub'

    }

    stages{

        stage('Cleanup Workspace'){
            steps{
                script{
                    cleanWs()
                }
            }

        }
        stage('Check SCM'){
            steps{
                script{

                    git credentialsId: 'github',
                    url: 'https://github.com/hashirama-hub/cicd_project_1.git',
                    branch: 'master'
                }

            }
            
        }
        stage('Build Docker Image'){
            steps{
                script{
                    
                    docker_image = docker.build "${IMAGE_NAME}"
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('', REGISTRY_CREPS){
                        docker_image.push("$BUILD_NUMBER")
                        docker_image.push("laster")
                    }
                }
            }
        }
        stage('Delete Docker Image'){
            steps{
                script{
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:laster"
                }
            }
        }
        stage('Update Kubernetes File'){
            steps{
                script{
                    sh """
                    cat deployment.yml
                    sed -i 's/${APP_NAME}.*/${APP_NAME}:${IMAGE_TAG}/g' deployment.yml
                    cat deployment.yml
                    
                    
                    """
                }
            }
        }
        stage('Push The Change Deployment File To Git'){
            steps{
                script{
                    sh """
                    git config --global user.name "tuanlinh"
                    git config --global user.email "tuanlinh060300@gmail.com"
                    git add deployment.yml
                    git commit -m "update file deployment"
                    
                    """
                    withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
                        sh "git push https://github.com/hashirama-hub/cicd_project_1.git master"

}
                }
            }
        }
        
    }

}