#!/bin/bash

SWARM_ARGS=""
SWARM_ARGS="${SWARM_ARGS} -fsroot ${JENKINS_HOME:-/var/jenkins}";
SWARM_ARGS="${SWARM_ARGS} -mode ${JENKINS_MODE:-normal}";

# mandatory
[[ -n "${JENKINS_USER}" && -n "${JENKINS_PASS}" ]]  && SWARM_ARGS="${SWARM_ARGS} -username ${JENKINS_USER} -passwordEnvVariable JENKINS_PASS" || { java -jar /usr/share/jenkins/swarm-client.jar --help; exit 10; };

# optionals
[[ -n "${LABELS}" ]]        && SWARM_ARGS="${SWARM_ARGS} -labels \"${LABELS}\"";

# MASTER URL
JENKINS_URL=${JENKINS_URL:-jenkins};
JENKINS_PORT=${JENKINS_PORT:-80};
[[ -n "${JENKINS_URL}" ]]   && SWARM_ARGS="${SWARM_ARGS} -master http://${JENKINS_URL}:${JENKINS_PORT}";

echo "java -jar /usr/share/jenkins/swarm-client.jar ${SWARM_ARGS} ${EXTRA_ARGS}"
java -jar /usr/share/jenkins/swarm-client.jar ${SWARM_ARGS} ${EXTRA_ARGS}