All server settings fall under `#!toml [server]`.

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
