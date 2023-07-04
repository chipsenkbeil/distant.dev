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

### Client

All client settings fall under `#!toml [client]`.

```toml
[client]
log_level = "trace"

[client.launch]
bin = "/path/to/distant"
```

#### log_file

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

#### log_level

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

#### api.timeout

TODO

#### api.unix_socket

TODO

#### api.windows_pipe

TODO

#### connect.options

TODO

#### launch.bin

TODO

#### launch.bind_server

TODO

#### launch.args

TODO

#### launch.options

TODO

### Generate

All generate settings fall under `#!toml [generate]`.

```toml
[generate]
log_level = "trace"
```

#### log_file

TODO

#### log_level

TODO

### Manager

All manager settings fall under `#!toml [manager]`.

```toml
[manager]
log_level = "trace"
access = "group"
```

#### log_file

TODO

#### log_level

TODO

#### access

TODO

#### unix_socket

TODO

#### windows_pipe

TODO

### Server

All server settings fall under `#!toml [manager]`.

```toml
[server]
log_level = "trace"

[server.listen]
port = "8080"
```

#### log_file

TODO

#### log_level

TODO

#### listen.host

TODO

#### listen.port

TODO

#### listen.use_ipv6

TODO

#### listen.shutdown

TODO

#### listen.current_dir

TODO

#### watch.native

TODO

#### watch.poll_interval

TODO

#### watch.compare_contents

TODO

#### watch.debounce_timeout

TODO

#### watch.debounce_tick_rate

TODO
