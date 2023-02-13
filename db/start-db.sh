#!/bin/bash


### Helper Functions ###

function getContainerHealth {
  podman inspect --format "{{.State.Health.Status}}" $1
}

function waitContainer {
  while STATUS=$(getContainerHealth $1); [ $STATUS != "healthy" ]; do 
    if [ $STATUS == "unhealthy" ]; then
      echo "Failed!"
      exit -1
    fi
    printf .    
    sleep 1
  done
  lf=$'\n'
  printf "$lf"
}

### Entry Point ###

echo "Start db container"

podman run --name db \
-d \
-p 13306:3306 \
-e MYSQL_USER=testuser \
-e MYSQL_PASSWORD=mypa55 \
-e MYSQL_DATABASE=tasks \
-e MYSQL_ROOT_PASSWORD=adminpa55 \
--health-cmd='mysqladmin ping --silent' \
registry.redhat.io/rhel8/mysql-80:1

echo "Wait for mysql container to be ready"
waitContainer db

echo "Execute DDL"
mysql -utestuser -h 127.0.0.1 -P13306 -pmypa55 tasks < ./create-db.sql

echo "Load test data"
mysql -utestuser -h 127.0.0.1 -P13306 -pmypa55 tasks < ./test-data.sql