# rustbuilder
This is a Docker image we can use to build Rust applications.

## Why not just use the official 'rust' Docker image?
Because the official Rust docker image is broken for 32 bit platforms
like linux/arm/v7.  This has been reported, but until it's fixed this image
works.

## What else is in here?
If you're wondering why this image is a little larger than it needs to be,
I install a couple of other useful things that I need for my build
processes; specifically `cargo-build-dependencies` and `cargo-audit`, along
with the OS dependencies needed to build and install them and Rust itself.

