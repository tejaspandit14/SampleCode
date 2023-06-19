pipeline{
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    // agent any
    // agent {
    //             label 'docker'
    //         }
    agent none
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

    stages{
        stage('Checkout'){
            agent {
                label 'docker'
            }
            steps{
                git 'https://github.com/tejaspandit14/SampleCode.git'
            }
        }
        stage('Compile'){
            agent {
                label 'docker'
            }
            steps{
                sh 'mvn compile'
            }
        }
        stage('CodeReview'){
            agent {
                label 'docker'
            }
            steps{
                sh 'mvn pmd:pmd'
            }
            // post{
            //     always{
            //         pmd pattern: 'target/pmd.xml'
            //     }
            // }
        }
        stage('UnitTest'){
            agent {
                label 'docker'
            }
            steps{
                sh 'mvn test'
            }
        }
        // stage('MetricCheck'){
        //     steps{
        //         sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
        //     }
            // post{
            //     always{
            //         cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
            //     }
            // }
        // }
        stage('Package'){
            agent {
                label 'docker'
            }
            steps{
                sh 'mvn package'
            }
        }
        stage('Docker build Image'){
            steps{
                sh """
                rm -rf jenkins-docker
                mkdir jenkins-docker
                cp /home/admin/agent/workspace/$JOB_NAME/target/addressbook.war jenkins-docker/
                docker build -t deploy:$BUILD_NUMBER .
                #docker run -itd -P deploy:$BUILD_NUMBER
                docker tag deploy:$BUILD_NUMBER tejaspandit/addressbookbuild:$BUILD_NUMBER
                docker rmi deploy:$BUILD_NUMBER
                """
            }
        }
        stage('Docker Push image') {
            agent {
                label 'docker'
            }
            steps {
			    sh """
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push tejaspandit/addressbookbuild:$BUILD_NUMBER
                docker rmi tejaspandit/addressbookbuild:$BUILD_NUMBER
                """
			}
        }
        stage('K8 Deployment'){  
        agent any
        steps{
            sh """
            kubectl run addressbook --image=tejaspandit/addressbookbuild:$BUILD_NUMBER --port=8080
            """
        }           
    }
    }
    post {
    always {
      sh 'docker logout'
    }
  }
}
