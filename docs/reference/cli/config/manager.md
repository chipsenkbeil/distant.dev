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
