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
                wrap([$class: 'BuildUser']) {
                          sh 'echo "${BUILD_USER}"'
                        }
						}
        }
    }
}

