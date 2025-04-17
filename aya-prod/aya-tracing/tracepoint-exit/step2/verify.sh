#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya grep 'read_at' tracepoint-binary-ebpf/src/hook_exit.rs
