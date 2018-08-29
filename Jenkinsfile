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
                sh 'mkdir web'
                sh 'cp -r . web/'
                sh 'alias dev="ssh jenkins@dev.indiedevshop.com"'
                sh 'dev "sudo rm -rf /var/www/web"'
                sh 'rsync -avz -e ssh web/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
