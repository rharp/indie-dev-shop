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
                sshagent(['JenkinsSSHKey']) {
                   sh 'ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com'
                }
						}
        }
    }
}

