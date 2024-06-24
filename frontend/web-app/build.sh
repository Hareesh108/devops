#!/bin/sh

init() {
      # Set env variables based on environment file
    case $ENVIRONMENT in
        test)
            source ./.env.test
            ;;
        dev)
            source ./.env.development
            ;;
        stage)
            source ./.env.stage
            ;;
        production)
            source ./.env.production
            ;;
        *)
            echo "Unknown environment: $ENVIRONMENT"
            exit 1
            ;;
    esac
    #set env variables
    export DOCKER_HOST="www.google.com"
    export DOCKER_USERNAME="admin"
    export DOCKER_PASSWORD="admin"
}

dockerize() {
    #build the docker image for checked out module
    sudo docker build --build-arg REACT_APP_DIGIBANK_API_ENDPOINT=$REACT_APP_DIGIBANK_API_ENDPOINT\
                      --build-arg REACT_APP_CLIENT_ID=$REACT_APP_CLIENT_ID\
                      --build-arg REACT_APP_CLIENT_SECRET=$REACT_APP_CLIENT_SECRET\
                      --build-arg REACT_APP_CC_CLIENT_ID=$REACT_APP_CC_CLIENT_ID\
                      --build-arg REACT_APP_CC_CLIENT_SECRET=$REACT_APP_CC_CLIENT_SECRET\
                      --build-arg REACT_APP_CC_SCOPE=$REACT_APP_CC_SCOPE\
                      --build-arg REACT_APP_CC_GRANT_TYPE=$REACT_APP_CC_GRANT_TYPE\
                      --build-arg REACT_APP_FORGEROCK_URL=$REACT_APP_FORGEROCK_URL\
    -t $DOCKER_HOST/$SERVICE-$ENVIRONMENT:$BUILD_NUMBER .

    #login into private docker registry
    sudo docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD $DOCKER_HOST

    #tag the docker image as latest
    sudo docker tag $DOCKER_HOST/$SERVICE-$ENVIRONMENT:$BUILD_NUMBER $DOCKER_HOST/$SERVICE-$ENVIRONMENT:"latest"

    #push the docker image into registry
    sudo docker push $DOCKER_HOST/$SERVICE-$ENVIRONMENT:$BUILD_NUMBER

    #push the docker image into registry
    sudo docker push $DOCKER_HOST/$SERVICE-$ENVIRONMENT:"latest"
}

args() {
    if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo "\nusage: build service environment"
        exit -1
    fi
    export SERVICE="$1"
    export ENVIRONMENT="$2"
    export ARG_DOCKER="$3"
}

run() {
    args $@
    init
    dockerize
}

run $@

