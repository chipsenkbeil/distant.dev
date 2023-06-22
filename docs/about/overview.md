Distant is a collection of tooling and libraries to support working with remote
machines. In its simplest form, there is a client and server where you run the
client on your local machine and the server on a remote machine. A TCP
connection is established between the client and server, and from there you are
able to edit files and run programs on the remote machine.

* Reading, writing, and querying a remote filesystem
  * File IO
  * Directory IO
  * Search
* Executing and managing processes on the remote machine
  * Run programs, writing to their stdin, and reading from their stdout/stderr
  * Spawn shells using a PTY

The distant cli is monolithic, meaning that all features are
contained in a single binary. This means that you do not need to install
a different program to run the client, server, or manager. You also do not need
to worry about having different shared libraries (.so) or DLLs (.dll)
available on your system to run distant.

## Details

The distant binary supplies both a server and client component as well as
a command to start a server and configure the local client to be able to
talk to the server.

* Asynchronous in nature, powered by [tokio](https://tokio.rs/)
* Data is serialized to send across the wire via
  [msgpack](https://msgpack.org/)
* Encryption & authentication are handled via
  [XChaCha20Poly1305](https://tools.ietf.org/html/rfc8439) for an authenticated
  encryption scheme via
  [RustCrypto/ChaCha20Poly1305](https://github.com/RustCrypto/AEADs/tree/master/chacha20poly1305)

Additionally, the core of the distant client and server codebase can be pulled
in to be used with your own Rust crates via the
[distant-core](https://crates.io/crates/distant-core) crate. The networking
library, which is agnostic of distant protocols, can be used via the
[distant-net](https://crates.io/crates/distant-net) crate.
