#!/bin/bash

docker container ls -f name=ayaq -q | wc -l | grep '^1$'
