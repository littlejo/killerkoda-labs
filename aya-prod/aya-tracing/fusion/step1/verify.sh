#!/bin/bash

docker container ls -f name=aya -q | wc -l | grep '^1$'
docker exec aya cargo build
docker exec aya grep 'BUF' tracepoint-binary-ebpf/src/common.rs | grep LruHashMap
docker exec aya grep 'BUF' tracepoint-binary-ebpf/src/hook.rs
docker exec aya grep 'BUF' tracepoint-binary-ebpf/src/filter.rs
docker exec aya grep 'BUF' tracepoint-binary-ebpf/src/display.rs
