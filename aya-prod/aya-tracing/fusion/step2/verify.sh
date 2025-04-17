#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya grep 'BUF' tracepoint-binary-ebpf/src/hook_exit.rs 
docker exec aya grep 'from_utf8_unchecked' tracepoint-binary-ebpf/src/hook_exit.rs 
