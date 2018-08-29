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
                sh 'mkdir ../html'
                sh 'cp -r ./ ../html'
                sh 'sudo rm -rf ../html'
                sh 'ssh jenkins@dev.indiedevshop.com'
                sh 'sudo rm -rf /var/www/html'
                sh 'exit'
                sh 'rsync -avz -e ssh ../html/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
