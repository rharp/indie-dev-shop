#!/usr/bin/env groovy

pipeline {
		agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'composer install --ignore-platform-reqs'
            }
        }
        stage('Transfering Files') {
        	 steps {
        				echo 'Transfering..'
                sh 'rm -rf ../html'
                sh 'mkdir ../html'
                sh 'cp -r ./ ../html'
        	 			sshagent (['JenkinsSSHKey']) {
									sh "ssh jenkins@dev.indiedevshop.com \"echo ${env.BUILD_ID}\""
								}
						}
        }
    }
}

