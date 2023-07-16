Connects to a remote machine through some method. Today, distant supports two
schemes: distant and ssh.

{{ asciinema("/assets/videos/connecting-distant.cast") }}

### Flags

* `--format <FORMAT>`: determines how connecting is handled when it comes to
  communication. By default, authentication requests are handled with
  human-readable prompts. With *json* specified, authentication will be
  provided using JSON-formatted requests and responses.

* `--options <OPTIONS>`: implementation-specific options to provide when
  connecting. These can vary based on using *distant* or *ssh* as the scheme.

### Options for distant://

* `key`: provide the authentication key to streamline authentication versus
  needing to answer the authentication prompt.

### Options for ssh://

All options for ssh have `ssh.` as an optional prefix. For example, you can
supply `backend` or `ssh.backend` as the key.

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

* `ssh.user_known_hosts_files`: specifies one or more files to use for the user
  host key database. These are comma-separated and default to:

      * `~/.ssh/known_hosts`
      * `~/.ssh/known_hosts2`

* `ssh.verbose`: if true, output tracing information from the underlying ssh
  implementation.

### Examples

#### Connecting to a distant server

When connecting to a distant server, you need to use the *distant* scheme and
provide an explicit port such as `8080` as seen below:

```sh
distant connect distant://example.com:8080
```

#### Supplying an authentication key as an option to a distant server

```sh
distant connect distant://example.com --options 'key=abcd'
```

#### Connecting to an ssh server

When connecting to an ssh server, you need to use the *ssh* scheme. If a port
is not specified, the default port of 22 is used as seen below:

```sh
distant connect ssh://example.com
```

#### Supplying ssh-specific options

```sh
distant connect ssh://example.com \
  --options 'backend=libssh,verbose=true,identity_files="path/to/file1,path/to/file2"'
```

{{ run("distant connect --help", admonition="info") }}
