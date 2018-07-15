#!/bin/bash

## Get latest agent
/usr/bin/wget "${JENKINS_MASTER}/jnlpJars/agent.jar" -O /home/jenkins/agent.jar

java -jar /home/jenkins/agent.jar -jnlpUrl "${JENKINS_MASTER}/computer/${COMPUTER_NAME}/slave-agent.jnlp" -secret "$JENKINS_SECRET" -workDir "${WORK_DIR}"