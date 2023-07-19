This plugin acts as a wrapper around the `distant` binary. In order for this
plugin to function, you need to have the `distant` binary installed on your
local machine and accessible from neovim.

Sound complicated? Not to worry! This plugin provides support to automatically
install the binary for you and will automatically begin the dialog when you
first attempt to invoke a command or function associated with the plugin.

## Installation process

!!! note

    If you already have the `distant` binary (or `distant.exe` on Windows)
    accessible (i.e. on your path), then you can skip this installation
    process! Just make sure that you have a version installed that is
    compatible with the neovim plugin!

You can trigger the installation dialog manually by running `:DistantInstall`,
which will check if you have a copy of `distant` available that is the correct
version. If the version is incompatible or no copy of `distant` is found, a
dialog will trigger offering three choices:

1. Download a prebuilt binary
2. Build from source
3. Copy local binary

### Download a prebuilt binary

Selecting this option will query Github releases for compatible versions,
downloading the release you select. The specific binary will be downloaded
based on the detected operation system and architecture of your local machine. 

For instance, an M1 Mac will download `distant-aarch64-apple-darwin` whereas an
Intel-based Linux machine will download `distant-x86_64-unknown-linux-gnu`. The
downloaded binary will be renamed to work with this plugin.

This requires that your machine have `curl`, `wget`, or `fetch` installed and
available on your path.

#### Available binaries

| Operating System | Architecture   | Binary                                                         |
| ---------------- | ------------   | ------                                                         |
| Windows          | x86_64         | [x86_64-pc-windows-mscv][x86_64-pc-windows-mscv]               |
| Windows          | aarch64        | [aarch64-pc-windows-mscv][aarch64-pc-windows-mscv]             |
| MacOS            | x86_64         | [x86_64-apple-darwin][x86_64-apple-darwin]                     |
| MacOS            | aarch64        | [aarch64-apple-darwin][aarch64-apple-darwin]                   |
| Linux            | x86_64 (GNU)   | [x86_64-unknown-linux-gnu][x86_64-unknown-linux-gnu]           |
| Linux            | x86_64 (MUSL)  | [x86_64-unknown-linux-musl][x86_64-unknown-linux-musl]         |
| Linux            | aarch64 (GNU)  | [aarch64-unknown-linux-gnu][aarch64-unknown-linux-gnu]         |
| Linux            | aarch64 (MUSL) | [aarch64-unknown-linux-musl][aarch64-unknown-linux-musl]       |
| Linux            | arm-v7 (GNU)   | [armv7-unknown-linux-gnueabihf][armv7-unknown-linux-gnueabihf] |
| Dragonfly BSD    | x86_64         | **(not yet supported)**                                        |
| FreeBSD          | x86_64         | [x86_64-unknown-freebsd][x86_64-unknown-freebsd]               |
| NetBSD           | x86_64         | **(not yet supported)**                                        |
| OpenBSD          | x86_64         | **(not yet supported)**                                        |

!!! note

    For Linux operating systems, you have a choice of
    [glibc](https://www.gnu.org/software/libc/) (GNU) [musl
    libc](https://musl.libc.org/). The installer will pick GNU, so if you want
    the musl version, you will need to download it yourself.

### Build from source

Selecting this option will download the latest copy of the distant repository
from https://github.com/chipsenkbeil/distant.

Once downloaded, the source will be built using `cargo build --release` and the
resulting binary will be copied into the appropriate location.

This requires that your machine have both `git` and `cargo` installed.
Additionally, due to the build requirements of distant's library, you will
also need `perl` to build a vendored copy of `openssh`.

### Copy local binary

Selecting this option will prompt for the path to an executable to copy to the
lua directory of this plugin.

[x86_64-pc-windows-mscv]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-x86_64-pc-windows-mscv.exe
[aarch64-pc-windows-mscv]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-aarch64-pc-windows-mscv.exe
[x86_64-apple-darwin]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-x86_64-apple-darwin
[aarch64-apple-darwin]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-aarch64-apple-darwin
[x86_64-unknown-linux-gnu]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-x86_64-unknown-linux-gnu
[x86_64-unknown-linux-musl]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-x86_64-unknown-linux-musl
[aarch64-unknown-linux-gnu]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-aarch64-unknown-linux-gnu
[aarch64-unknown-linux-musl]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-aarch64-unknown-linux-musl
[armv7-unknown-linux-gnueabihf]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-armv7-unknown-linux-gnueabihf
[x86_64-unknown-freebsd]: https://github.com/chipsenkbeil/distant/releases/latest/download/distant-x86_64-unknown-freebsd
