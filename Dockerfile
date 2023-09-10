FROM rust:slim AS builder
RUN apt-get update && apt-get install -y perl cmake make g++ librdkafka-dev curl pkg-config libssl-dev

WORKDIR /usr/src/app

COPY . .

RUN cargo build --release


FROM debian:stable-20230904-slim
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/target/release/git-demo ./
CMD [ "./git-demo" ]

