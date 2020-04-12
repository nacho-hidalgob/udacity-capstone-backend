#!/bin/bash

LOGIN_SCRIPT=$(aws ecr get-login --no-include-email)
LOGIN=$(eval ${LOGIN_SCRIPT})
ECR=$(echo ${LOGIN_SCRIPT} | cut -d/ -f3)
echo $ECR