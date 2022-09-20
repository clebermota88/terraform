pipeline{
    agent any
     
     stages {
        stage ('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("clebermota88/app:${env.BUILD_ID}-${action}", '-f ./app/Dockerfile ./app')
                }
            }
            
        }
        stage (' Push Image ') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push("Latest-${action}")
                        dockerapp.push("${env.BUILD_ID}-${action}")
                    }
                }
            }
        }
        stage (' Deploy Docker ' ) {
            steps {
                script {
                    echo "Docker Image ID: ${env.BUILD_ID} Deploy em ${action}"

                    if ("${action}" == 'Producao') {
                        DOCKER_PROD_0 = "" #configurar o IP em variavel de ambiente
                        DOCKER_PROD_1 = "" #configurar o IP em variavel de ambiente

                         sh "docker --host ${DOCKER_PROD_0} stop App-${action} || true"
                         sh "docker --host ${DOCKER_PROD_0} rm -f App-${action} || true"
                         sh 'ssh ubuntu@10.1.101.158 "sudo docker rmi $(docker images -q)" || true' #teste
                         sh "docker --host ${DOCKER_PROD_0} run --name APP-${action} -d -p 5000:5000 clebermota88/app:${env.BUILD_ID}-${action}"
                         # 2 VM   
                         sh "docker --host ${DOCKER_PROD_1} stop App-${action} || true"
                         sh "docker --host ${DOCKER_PROD_1} rm -f App-${action} || true"
                         sh 'ssh ubuntu@10.1.102.71 "sudo docker rmi $(docker images -q)" || true' #teste
                         sh "docker --host ${DOCKER_PROD_1} run --name App-${action} -d -p 5000:5000 clebermota88/app:${env.BUILD_ID}-${action}"
                    }
                    if ("${action}" == 'Desenvolvimento') {
                        sh "docker stop App-${action} || true && docker rm -f App-${action}  || true"
                        sh "docker rmi -f clebermota88/app:${currentBuild.previousBuild.number}-${action} || true"
                        sh "docker run --name App-${action} -d -p 4000:4000 clebermota88/app:${env.BUILD_ID}-${action}"
                    }
                    if ("${action}" == 'Teste') {
                         DOCKER_HOST = "" #configurar o IP em variavel de ambiente
                         sh "docker --host ${DOCKER_HOST} stop App-${action} || true"
                         sh "docker --host ${DOCKER_HOST} rm -f App-${action} || true"
                         sh 'ssh ubuntu@10.1.101.108 "sudo docker rmi -f $(docker image ls -a -q)" || true' #teste
                         sh "docker --host ${DOCKER_HOST} run --name App-${action} -d -p 4000:4000 clebermota88/app:${env.BUILD_ID}-${action}"
                    }
                }
            }
        }
     }
}