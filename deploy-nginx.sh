#!/bin/bash

IS_GREEN=$(docker ps | grep green)
IMAGE_TAG=$1

if [ -z "$IMAGE_TAG" ]; then
  echo "ERROR: Image tag argument is missing."
  exit 1
fi

if [ -z "$IS_GREEN"  ];then

  echo "### BLUE => GREEN ###"

  echo "1. get green image"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml pull green

  echo "2. green container up"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml up -d green
  while [ 1 = 1 ]; do
  echo "3. green health check..."
  sleep 3

  REQUEST=$(curl http://127.0.0.1:8082)
    if [ -n "$REQUEST" ]; then
            echo "health check success"
            break ;
            fi
  done;

  echo "4. reload nginx"
  sudo cp /home/ubuntu/cicd/nginx-green.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. blue container down"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml stop blue
else
  echo "### GREEN => BLUE ###"

  echo "1. get blue image"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml pull blue

  echo "2. blue container up"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml up -d blue

  while [ 1 = 1 ]; do
    echo "3. blue health check..."
    sleep 3
    REQUEST=$(curl http://127.0.0.1:8081)

    if [ -n "$REQUEST" ]; then
      echo "health check success"
      break ;
    fi
  done;

  echo "4. reload nginx"
  sudo cp /home/ubuntu/cicd/nginx-blue.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. green container down"
  docker-compose -f /home/ubuntu/cicd/docker-compose.yml stop green
fi