FROM ubuntu:bionic as builder
ARG BUILDPLATFORM
ARG TARGETPLATFORM
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y clang curl git
RUN apt-get install -y libssl-dev pkg-config
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
RUN cargo install cargo-audit

# Not sure how I didn't need to do this separately before, but clearly I do now
RUN cargo install sccache

# Now cd to the /usr/src directory and do a build
# (although the expectation is you'll use this image as a base rather than
# ever actually running it directly)
WORKDIR /usr/src
COPY files/cargo.sh ./

CMD /bin/bash
