#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya grep 'bpf_get_current_pid_tgid' tracepoint-binary-ebpf/src/hook.rs
docker exec aya grep 'bpf_get_current_pid_tgid' tracepoint-binary-ebpf/src/hook_exit.rs
docker exec aya grep 'LruHashMap' tracepoint-binary-ebpf/src/common.rs
