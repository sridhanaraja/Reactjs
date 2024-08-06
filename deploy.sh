#! /bin/bash
# GET CURRENT BRANCH:
BRANCH_NAME=$(env.GIT_BRANCH.split('/').last())
sh 'docker-compose down'  
if ["$BRANCH_NAME"="dev"]; then
    sh 'chmod +x build.sh'
    sh './build.sh'
    DOCKER_REPO="smart24/myapp-dev"
    docker tag myapp:${BUILD_NUMBER} $DOCKER_REPO:${BUILD_NUMBER}
    docker push $DOCKER_REPO:${BUILD_NUMBER}
    docker push $DOCKER_REPO:latest
elif ["$BRANCH_NAME"="main"]; then
    sh 'chmod +x build.sh'
    sh './build.sh'
    DOCKER_REPO="smart24/myapp-prod"
    docker tag myapp:${BUILD_NUMBER} $DOCKER_REPO:${BUILD_NUMBER}
    docker push $DOCKER_REPO:${BUILD_NUMBER}
    docker push $DOCKER_REPO:latest

else echo "Branch not configured for deployment" exit 1
fi
