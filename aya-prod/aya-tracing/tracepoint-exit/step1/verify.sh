#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya ls tracepoint-binary-ebpf/src/hook_exit.rs
docker exec aya grep 'mod hook_exit' tracepoint-binary-ebpf/src/main.rs 
docker exec aya grep 'sys_exit_execve' tracepoint-binary/src/main.rs 

