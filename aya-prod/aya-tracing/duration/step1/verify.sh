#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya grep 'bpf_ktime_get_ns()' tracepoint-binary-ebpf/src/hook.rs
docker exec aya grep 'bpf_ktime_get_ns()' tracepoint-binary-ebpf/src/hook_exit.rs
