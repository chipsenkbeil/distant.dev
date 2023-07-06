All client settings fall under `#!toml [client]`.

```toml
[client]
log_level = "trace"

[client.launch]
bin = "/path/to/distant"
```

### log_file

<div class="grid" markdown>

=== "About"

    Specifies an alternative path to use when logging information while the
    client is running.

=== "Value"

    String representing the path to the file.

```toml title="Example"
[client]
log_file = "/path/to/file.log"
```

</div>

### log_level

<div class="grid" markdown>

=== "About"

    Specifies the log level used when logging information while the client
    is running.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```toml title="Example"
[client]
log_level = "info"
```

</div>

### api.timeout

<div class="grid" markdown>

=== "About"

    Maximum time (in seconds) to wait for an API network request to complete
    before timing out where 0 indicates no timeout will occur.

=== "Value"

    Integer time in seconds. **[default: 0]**

```toml title="Example"
[client]
[client.api]
timeout = 60
```

</div>

### api.unix_socket

<div class="grid" markdown>

=== "About"

    Alternative unix domain socket to connect to when using a manger
    (Unix only).

=== "Value"

    String representing the path to the socket file.

```toml title="Example"
[client]
[client.api]
unix_socket = "/path/to/distant.sock"
```

</div>

### api.windows_pipe

<div class="grid" markdown>

=== "About"

    Alternative name for a local named Windows pipe to connect to when using a
    manager (Windows only).

=== "Value"

    String representing the name of the local Windows pipe.

```toml title="Example"
[client]
[client.api]
windows_pipe = "some_name"
```

</div>

### connect.options

<div class="grid" markdown>

=== "About"

    Additional options to provide, typically forwarded to the handler within
    the manager facilitating the connection.

=== "Value"

    String of key-value pairs separated by commas.
    E.g. `key="value",key2="value2"`.

```toml title="Example"
[client]
[client.connect]
options = "ssh.backend=\"libssh\",value=\"123\""
```

</div>

### launch.bin

<div class="grid" markdown>

=== "About"

    Path to distant program on remote machine to execute via ssh; by default,
    this program needs to be available within `PATH` as specified when
    compiling ssh (not your login shell).

=== "Value"

    String representing the path to the distant binary.

```toml title="Example"
[client]
[client.launch]
bin = "/path/to/distant"
```

</div>

### launch.bind_server

<div class="grid" markdown>

=== "About"

    Control the IP address that the server binds to.

=== "Value"

    String describing the interface the server should bind to.

    * `ssh` - the server will reply from the IP address that the ssh connection
      came from as found in the `SSH_CONNECTION` environment variable. This is
      useful for multihomed servers.

    * `any` - the server will reply on the default interface and will not bind
      to a particular IP address. This can be useful if the connection is made
      through sslh or another tool that makes the SSH connection appear to come
      from localhost.

    * `<IP>` - the server will attempt to bind to the specified IP address.

```toml title="Example"
[client]
[client.launch]
bind_server = "192.168.1.5"
```

</div>

### launch.args

<div class="grid" markdown>

=== "About"

    Additional arguments to provide to the server when launching it.

=== "Value"

    String representing the additional CLI options.

```toml title="Example"
[client]
[client.launch]
args = "--shutdown lonely=60 --use-ipv6"
```

</div>

### launch.options

<div class="grid" markdown>

=== "About"

    Additional options to provide, typically forwarded to the handler within
    the manager facilitating the launch of a distant server.

=== "Value"

    String of key-value pairs separated by commas.
    E.g. `key="value",key2="value2"`.

```toml title="Example"
[client]
[client.launch]
options = "ssh.backend=\"libssh\",value=\"123\""
```

</div>
