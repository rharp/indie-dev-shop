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
        				sshagent(['JenkinsSSHKey']) {
                	sh '''
                     alias dev="ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com"
                     dev "rm -rf /var/www/temp_deploy"
                     dev "mkdir -p /var/www/temp_deploy"
                     scp --o StrictHostKeyChecking=no -r ../html jenkins@dev.indiedevshop.com:/var/www/temp_deploy/dist
                     dev "rm -rf /var/www/example.com/dist/ && mv /var/www/temp_deploy/dist/ /var/www/example.com/"
                '''
                }
                sh 'rm -rf ../html'
						}
        }
    }
}

