pipeline{
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    // agent any
    agent {
                label 'docker'
            }
    stages{
        stage('Checkout'){
            steps{
                git 'https://github.com/tejaspandit14/SampleCode.git'
            }
        }
        stage('Compile'){
            steps{
                sh 'mvn compile'
            }
        }
        stage('CodeReview'){
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
            steps{
                sh 'mvn package'
            }
        }
        stage('Docker build'){
            steps{
                sh """
                rm -rf jenkins-docker
                mkdir jenkins-docker
                cp /home/admin/agent/workspace/devops/target/addressbook.war jenkins-docker/
                docker build -t deploy:$BUILD_NUMBER .
                docker run -itd -P deploy:$BUILD_NUMBER
                """
            }
        }        
    }
}
