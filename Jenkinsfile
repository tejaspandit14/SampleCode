pipeline{
    tools{
        jdk 'myjava'
        maven 'mymaven'
    }
    agent any
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
            }
        }
        stage('UnitTest'){
            steps{
                sh 'mvn test'
            }
        }
        stage('MetricCheck'){
            steps{
                sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
            }
            post{
                always{
                    cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
                }
            }
        }
        stage('Package'){
            steps{
                sh 'mvn package'
            }
        }
    }
}
