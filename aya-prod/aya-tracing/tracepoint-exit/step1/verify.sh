#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec -it aya cargo build
docker exec -it aya ls tracepoint-binary-ebpf/src/hook_exit.rs
docker exec -it aya grep 'mod hook_exit' tracepoint-binary-ebpf/src/main.rs 
docker exec -it aya grep 'sys_exit_execve' tracepoint-binary/src/main.rs 

