+++
title = "Installation"
description = "Installation"
weight = 3
+++

## Prebuilt Binaries

Navigate to download a binary from the [releases
section](https://github.com/chipsenkbeil/distant/releases).

Out of the box, the distant CLI is available on the following platforms:

- Windows (x86)
- MacOS (x86 & aarch64)
- Linux GNU (x86, aarch64, armv7)
- Linux MUSL (x86, aarch64)

You can download any of the above binaries for the appropriate platform and not
need to worry about compiling source code or even having the Rust compiler on
your system!

## From source

To build distant from source, you will need to have
[Git](https://git-scm.com/), [Rust](https://www.rust-lang.org/), and
[Cargo](https://github.com/rust-lang/cargo) installed.

1. Clone the repository via `git clone https://github.com/chipsenkbeil/distant.git`
2. From the root of the repository, build via `cargo build --release`
3. Copy the output binary from `target/release/distant` (or
   `target/release/distant.exe` on Windows)
