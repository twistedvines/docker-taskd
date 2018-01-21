#!/usr/bin/env groovy

pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'make build'
      }
    }
    stage('Tag') {
      steps {
        sh 'make tag'
      }
    }
    stage('Push') {
      steps {
        sh 'make push'
      }
    }
  }
}
