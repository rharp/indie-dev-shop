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
                sh 'ssh jenkins@dev.indiedevshop.com'
                sh 'rm -rf /var/www/html'
                sh 'exit'
                sh 'rsync -avz -e ssh ../html/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
