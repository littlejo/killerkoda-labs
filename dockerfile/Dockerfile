FROM rust:slim-bullseye

RUN rustup default stable && \
    rustup toolchain add nightly && \
    rustup component add rust-src --toolchain nightly

RUN apt update && \
    apt install openssl libssl-dev pkg-config -y && \
    rm -rf /var/lib/apt/lists/*

RUN cargo install cargo-generate bpf-linker
