Connects to a remote machine through some method, starts a `distant`
server, and then connects to that server. The connection used to first
access the machine is closed.

{{ asciinema("/assets/videos/launching-distant.cast") }}

In the above example, the following happens:

1. An ssh connection is established with `example.com` as user `root`
2. A distant server is spawned via `distant server listen --daemon`
3. The port and authentication key are sent back to the client over ssh
4. The ssh connection is closed
5. The client attempts to connect to `example.com` over TCP using the provided
   port and authenticates using the provided key

### Flags

* `--distant <BIN>`: specifies the binary to use as an alternative to `distant`
  on the remote machine. This typically is used to provide the full path to
  `distant` on the remote machine in situations where it cannot be found.

* `--distant-bind-server <HOST>`: specifies the `--host` to apply to the
  spawned distant server. See [`distant server listen` flags](/reference/cli/commands/server/listen/#flags)
  for more information.

* `distant-args <ARGS`>: additional arguments to provide to the server when
  starting it.

* `--format <FORMAT>`: determines how launching is handled when it comes to
  communication. By default, authentication requests are handled with
  human-readable prompts. With *json* specified, authentication will be
  provided using JSON-formatted requests and responses.

* `--options <OPTIONS>`: implementation-specific options to provide when
  launching. These can vary based on using *distant* or *ssh* as the scheme.

### Options for manager://

* `distant.bin`: specify an alternative path to a distant binary to launch.
  Mirrors `--distant`.

* `distant.bind_server`: specify a value to use when binding the launched
  server to a network interface. Mirrors `--distant-bind-server`.

* `distant.args`: specify additional arguments to provide to the server when
  starting it. Mirrors `--distant-args`.

### Options for ssh://

All options for ssh have `ssh.` as an optional prefix (except `timeout`). For
example, you can supply `backend` or `ssh.backend` as the key.

* `distant.bin`: specify an alternative path to a distant binary to launch.
  Mirrors `--distant`.

* `distant.bind_server`: specify a value to use when binding the launched
  server to a network interface. Mirrors `--distant-bind-server`.

* `distant.args`: specify additional arguments to provide to the server when
  starting it. Mirrors `--distant-args`.

* `ssh.backend`: used by ssh to determine which client library to use both for
  authentication and general options. The choices are *ssh2* and *libssh* with
  *ssh2* being the default. If you encounter errors such related to banners,
  invalid protocol messages, etc. try to switch to *libssh*.

* `ssh.identity_files`: used to provide explicit list of files from which the
  user's DSA, ECDSA, Ed25519, or RSA authentication identity are read. These
  are comma-separated. Defaults are:

      * `~/.ssh/id_dsa`
      * `~/.ssh/id_ecdsa`
      * `~/.ssh/id_ed25519`
      * `~/.ssh/id_rsa`

* `ssh.identities_only`: if true, specifies that ssh should only use the
  configured authentication and certificate files (either the defaults or
  configured from `identity_files`).

* `ssh.proxy_command`: specifies the command to use to connect to the server.

* `timeout`: time in milliseconds to wait when connecting to the distant
  server after it has been spawned by the ssh session.

* `ssh.user_known_hosts_files`: specifies one or more files to use for the user
  host key database. These are comma-separated and default to:

      * `~/.ssh/known_hosts`
      * `~/.ssh/known_hosts2`

* `ssh.verbose`: if true, output tracing information from the underlying ssh
  implementation.

### Examples

#### Launching a server locally on the same machine

The `distant` CLI supports a custom scheme, *manager*, to denote that the
active manager should spawn a local distant server process and connect to it.
This process will be terminated once the manager shuts down. You can use any
host for the launch, but using `localhost` is common:

```sh
distant launch manager://localhost
```

#### Launching a server with custom logging information

Leveraging the `distant-args` flag, you can provide a log level, log file
location, and other details to the spawned server. This is a common approach
when you want to custom the start of the server from your local machine:

```sh
distant launch ssh://example.com \
    --distant-args '--log-level trace --log-file /tmp/server.log'
```

{{ run("distant launch --help", admonition="info") }}
