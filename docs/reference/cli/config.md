## Quickstart

=== "Unix"

    Create a file named `config.toml` in one of these locations:

    * `$XDG_CONFIG_HOME/distant/`
    * `$HOME/.config/distant/`

=== "MacOS"

    Create a file named `config.toml` in one of these locations:

    * `$HOME/Library/Application Support/distant/`

=== "Windows"

    Create a file named `config.toml` in one of these locations:

    * `%USERPROFILE%\AppData\Roaming\distant\config\`

Populate the `config.toml` file with some sample settings:

```toml
[server]
[server.listen]
port = "8080" # Listen exclusively on TCP port 8080
```

## Configuration File Structure

The configuration file is broken up into four categories:

* Client
* Generate
* Manager
* Server

Each category applies to one of the commands associated with the distant CLI.
For example `#!toml [server]` is associated with `distant server`. The only
exception is `#!toml [client]`, which is associated with all client-facing
commands such as `distant fs`, `distant launch`, and `distant shell`.

## Client

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

## Generate

All generate settings fall under `#!toml [generate]`.

```toml
[generate]
log_level = "trace"
```

### log_file

<div class="grid" markdown>

=== "About"

    Specifies an alternative path to use when logging information related to
    generating some content.

=== "Value"

    String representing the path to the file.

```toml title="Example"
[generate]
log_file = "/path/to/file.log"
```

</div>

### log_level

<div class="grid" markdown>

=== "About"

    Specifies the log level used when logging information related to generating
    some content.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```toml title="Example"
[generate]
log_level = "info"
```

</div>

## Manager

All manager settings fall under `#!toml [manager]`.

```toml
[manager]
log_level = "trace"
access = "group"
```

### log_file

<div class="grid" markdown>

=== "About"

    Specifies an alternative path to use when logging information while the
    manager is running.

=== "Value"

    String representing the path to the file.

```toml title="Example"
[manager]
log_file = "/path/to/file.log"
```

</div>

### log_level

<div class="grid" markdown>

=== "About"

    Specifies the log level used when logging information while the manager
    is running.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```toml title="Example"
[manager]
log_level = "info"
```

</div>

### access

<div class="grid" markdown>

=== "About"

    Level of access control to the unix socket or windows pipe that the manager
    creates and listens on for requests.

=== "Value"

    String representing the access level. **[default: owner]**

    * `owner` - read & write for owner (`0o600`).
    * `group` - read & write for owner and group (`0o660`).
    * `anyone` - read & write for owner, group, and other (`0o666`).

```toml title="Example"
[manager]
access = "group"
```

</div>

### unix_socket

<div class="grid" markdown>

=== "About"

    Alternative unix domain socket to listen on (Unix only).

=== "Value"

    String representing the path to the socket file.

```toml title="Example"
[manager]
unix_socket = "/path/to/distant.sock"
```

</div>

### windows_pipe

<div class="grid" markdown>

=== "About"

    Alternative name for a local named Windows pipe to listen on (Windows
    only).

=== "Value"

    String representing the name of the local Windows pipe.

```toml title="Example"
[manager]
windows_pipe = "some_name"
```

</div>

## Server

All server settings fall under `#!toml [manager]`.

```toml
[server]
log_level = "trace"

[server.listen]
port = "8080"
```

### log_file

<div class="grid" markdown>

=== "About"

    Specifies an alternative path to use when logging information while the
    server is running.

=== "Value"

    String representing the path to the file.

```toml title="Example"
[server]
log_file = "/path/to/file.log"
```

</div>

### log_level

<div class="grid" markdown>

=== "About"

    Specifies the log level used when logging information while the server
    is running.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```toml title="Example"
[server]
log_level = "info"
```

</div>

### listen.host

<div class="grid" markdown>

=== "About"

    IP address that the server will bind to.

=== "Value"

    String describing the interface the server should bind to.
    **[default: any]**

    * `ssh` - the server will reply from the IP address that the SSH connection
      came from (as found in the `SSH_CONNECTION` environment variable). This
      is useful for multihomed servers.

    * `any` - the server will reply on the default interface and will not bind
      to a particular IP address. This can be useful if the connection is made
      through ssh or another tool that makes the ssh connection appear to come
      from localhost.

    * `<IP>` - the server will attempt to bind to the specified IP address.

```toml title="Example"
[server]
[server.listen]
host = "192.168.1.5"
```

</div>

### listen.port

<div class="grid" markdown>

=== "About"

    Port(s) that the server will attempt to bind to.

=== "Value"

    String that can be in the form of `PORT` or `PORT1:PORTN` to provide a
    range of ports. **[default: 0]**

    With `0`, the server will let the operating system pick an available TCP
    port.

    !!! note

        This option does not affect the server-side port used by ssh.

```toml title="Example"
[server]
[server.listen]
port = "8080:8089"
```

</div>

### listen.use_ipv6

<div class="grid" markdown>

=== "About"

    Whether to bind to the ipv6 interface if host is `any` instead of ipv4.

=== "Value"

    Boolean indicating to use ipv6. **[default: false]**

```toml title="Example"
[server]
[server.listen]
use_ipv6 = true
```

</div>

### listen.shutdown

<div class="grid" markdown>

=== "About"

    Logic to apply to server when determining when to shutdown.

=== "Value"

    String representing shutdown rule. **[default: never]**

    * `never` - server will never automatically shut down.
    * `after=<N>` - server will shut down after `N` seconds.
    * `lonely=<N>` - server will shut down after `N` seconds with no connections.

```toml title="Example"
[server]
[server.listen]
shutdown = "lonely=60"
```

</div>

### listen.current_dir

<div class="grid" markdown>

=== "About"

    Current working directory (cwd) for the server.

=== "Value"

    String representing the path of the current working directory.
    **[default: parent proc cwd]**

```toml title="Example"
[server]
[server.listen]
current_dir = "/path/to/dir"
```

</div>

### watch.native

<div class="grid" markdown>

=== "About"

    Use native filesystem watching (more efficient).

=== "Value"

    Boolean indicating whether to use native filesystem watching or leverage a
    software polling of files and directories to detect changes.
    **[default: true]**

```toml title="Example"
[server]
[server.watch]
native = false
```

</div>

### watch.poll_interval

<div class="grid" markdown>

=== "About"

    Time between polls of files being watched, only relevant when using the
    polling watcher implementation (ignored with native watcher).

=== "Value"

    Integer time in seconds.

```toml title="Example"
[server]
[server.watch]
poll_interval = 30
```

</div>

### watch.compare_contents

<div class="grid" markdown>

=== "About"

    Load a file and compare its contents to detect file changes, only relevant
    when using the polling watcher implementation (**very slow**).

=== "Value"

    Boolean indicating if contents should be loaded to check for changes.
    **[default: false]**

```toml title="Example"
[server]
[server.watch]
compare_contents = true
```

</div>

### watch.debounce_timeout

<div class="grid" markdown>

=== "About"

    Maximum time to wait for filesystem changes before reporting them, which is
    useful to avoid noisy changes as well as serves to consolidate different
    events that represent the same action.

=== "Value"

    Time in seconds to wait for filesystem changes.
    **[default: 2]**

```toml title="Example"
[server]
[server.watch]
debounce_timeout = 0.5
```

</div>

### watch.debounce_tick_rate

<div class="grid" markdown>

=== "About"

    How often in seconds to check for new events before the debounce timeout
    occurs.

=== "Value"

    Time in seconds between checks for new events.
    **[default: 1/4 of debounce_timeout]**

```toml title="Example"
[server]
[server.watch]
debounce_tick_rate = 0.125
```

</div>
