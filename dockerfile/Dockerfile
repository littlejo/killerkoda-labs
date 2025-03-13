FROM rust:slim-bullseye as base

RUN rustup default stable && \
    rustup toolchain add nightly && \
    rustup component add rust-src --toolchain nightly

RUN apt update && \
    apt install openssl libssl-dev pkg-config -y && \
    rm -rf /var/lib/apt/lists/*

RUN cargo install cargo-generate bpf-linker

FROM base as builder

RUN apt update && apt install git -y && git clone https://github.com/littlejo/aya-examples /root/aya-examples

WORKDIR /root/aya-examples/tracepoint-binary

ENV CARGO_TARGET_DIR=/root/build-cache
RUN cargo build

FROM base as final
ENV CARGO_TARGET_DIR=/root/build-cache
COPY --from=builder /root/build-cache /root/build-cache
