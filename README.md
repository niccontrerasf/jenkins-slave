# Jenkins worker
----------

Based on behavior of **rancher/jenkins-swarm:v0.2.0** worker.

## Configuration
```Dockerfile
ENTRYPOINT ["java","-jar","/usr/share/jenkins/swarm-client.jar"]
CMD ["-fsroot","${JENKINS_HOME:-/var/jenkins}","${SWARM_ARGS}","-username ${JENKINS_USER}","-labels ${LABELS}","-passwordEnvVariable JENKINS_PASS","-master","http://${JENKNIS_URL:-jenkins}:${JENKINS_PORT:-8080}"]
```
# ENVS

### Mandatory
```sh
JENKINS_USER            # username
JENKINS_PASS            # password of the user
```

### optional
```sh
LABELS                  # space separated extra labels
JENKINS_HOME            # home to workspaces, default: /var/jenkins
SWARM_ARGS              # extra args to swarm-client
JENKINS_URL             # ip or domain of jenkins master server, default: jenkins
JENKINS_PORT            # port of jenkins master server, default 8080
```

# RUN

### normal worker
```sh
docker run -ti \
-e JENKINS_USER=user \
-e JENKINS_PASS=pass \
image:version
```
### docker build capable inside container
```sh
docker run -ti \
-e JENKINS_USER=user \
-e JENKINS_PASS=pass \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):$(which docker) image:version
```

## Pending
others architectures support primarly x86

----------

**big help, build other arch in DockerHub: https://stackoverflow.com/a/54595564/8011749**