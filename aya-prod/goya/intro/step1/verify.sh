#!/bin/bash

docker container ls -f name=goya -q | wc -l | grep '^1$'
