FROM ubuntu:bionic as builder
ARG BUILDPLATFORM
ARG TARGETPLATFORM
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y clang
RUN apt-get install -y curl
RUN apt-get install -y git
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

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

CMD /bin/bash
