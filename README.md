# rustbuilder
This is a Docker image we can use to build Rust applications.

## Why not just use the official 'rust' Docker image?
Because the official Rust docker image is broken for 32 bit platforms
like linux/arm/v7.  This has been reported, but no great enthusiasm to
do anything about it is being shown.

