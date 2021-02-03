#!/bin/bash

red=$'\e[1;31m'
green=$'\e[1;32m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[0m'

cecho ()                     # Color-echo.
                             # Argument $1 = message
                             # Argument $2 = color
{

  message=${1}   # Defaults to default message.
  color=${2}           # Defaults to black, if not specified.

  echo $color "$message" $white

  return
}

cecho "Please log in to azure with your credentials"
az login

#Deploy baseline infrastructure
cecho "Starting Terraform Deploy Script" $magenta
cd terraform
/bin/bash terraform_deploy.sh
cd ..
cecho "Finished Terraform Deploy" $green

#Deploy apps on top of baseline infrastructure
cecho "Starting App Systems Deploy" $magenta
cd appsystems
/bin/bash app_deploy.sh
cd ..
cecho "Finished App Systems Deploy" $green
