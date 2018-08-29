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
                alias dev="ssh jenkins@dev.indiedevstudio.com"
                dev "rm -rf /var/www/html";
                sh 'rsync -avz -e ssh ../html/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
