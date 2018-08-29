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
                sh 'mkdir html/'
                sh 'cp -r . html/'
                sh 'alias dev="ssh jenkins@dev.indiedevshop.com"'
                sh 'dev "sudo rm -rf /var/www/html"'
                sh 'rsync -avz -e ssh html/ jenkins@dev.indiedevshop.com:/var/www/'
            }
        }
    }
}
