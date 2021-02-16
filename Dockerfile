FROM ubuntu:bionic as builder
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y clang
RUN apt-get install -y curl

# Install Rust from scratch
WORKDIR /usr/rust
COPY files/installrust.sh ./
RUN ./installrust.sh  -y
ENV PATH="/root/.cargo/bin:$PATH"

# Also install the cargo-build-dependencies extension.  This is useful
# for derivative images to be able to build dependencies and then the app
# as two separate steps
WORKDIR /usr/src
RUN cargo install cargo-build-dependencies

# Now cd to the /usr/src directory and do a build
# (although the expectation is you'll use this image as a base rather than
# ever actually running it directly)
WORKDIR /usr/src
COPY files/cargo.sh ./
ENTRYPOINT [ "/usr/src/cargo.sh" ]
CMD [ "build" ]
