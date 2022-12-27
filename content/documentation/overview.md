+++
title = "Overview"
description = "Overview"
weight = 1
+++

## What is distant? 

## Installation

The `distant` CLI is monolithic, meaning that all features are
contained in a single binary. This means that you do not need to install
a different program to run the client, server, or manager. You also do not need
to worry about having different shared libraries (`.so`) or DLLs (`.dll`)
available on your system to run distant.

### Prebuilt Binaries

Out of the box, the distant CLI is available on the following platforms:

- Windows (x86)
- MacOS (x86 & aarch64)
- Linux GNU (x86, aarch64, armv7)
- Linux MUSL (x86, aarch64)

You can download any of the above binaries for the appropriate platform and not
need to worry about compiling source code or even having the Rust compiler on
your system!

If you would like a pre-built binary, check out the 
[releases section](https://github.com/chipsenkbeil/distant/releases).

### Via `cargo install`

If you have [cargo](https://github.com/rust-lang/cargo) installed, you can
directly download and build the most recent release via:

```bash
cargo install distant
```

Alternatively, you can clone this repository and build from source following
the [build guide](./BUILDING.md).
