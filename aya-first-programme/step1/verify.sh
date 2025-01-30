#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
