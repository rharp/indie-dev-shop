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
                sh 'ssh -vv jenkins@dev.indiedevstudio.com echo testing connection || true'
                sh 'rsync -avz -e ssh ../html/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
