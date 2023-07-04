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
