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

#Deploy baseline infrastructure
cecho "TEMPORARY - DEPLOYING APPS ON TOP OF INFRA" $magenta

#
# Deploy web app to AKS
#