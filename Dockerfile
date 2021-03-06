FROM openjdk:11-jdk-slim

# jar dir
ARG JAR_DIR=/usr/share/jenkins
# agent version
ARG AGENT_VERSION=4.3
# swarm client version
ARG SWARM_VERSION=2.0

VOLUME /var/jenkins

# apt update and packages
RUN apt-get update && \
  apt-get install -y curl git && \
  rm -rf /var/lib/apt/lists/*

# install docker
# RUN curl -fsSL https://get.docker.com -o get-docker.sh
# RUN sh get-docker.sh

# https://hub.docker.com/r/jenkins/agent/dockerfile
RUN curl --create-dirs -fsSLo ${JAR_DIR}/agent.jar \
  https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${AGENT_VERSION}/remoting-${AGENT_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 ${JAR_DIR}/agent.jar \
  && ln -sf ${JAR_DIR}/agent.jar ${JAR_DIR}/slave.jar

RUN curl --create-dirs -fsSLo ${JAR_DIR}/swarm-client.jar \
  https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar

COPY run.sh /run.sh

CMD [ "/bin/bash","/run.sh" ]