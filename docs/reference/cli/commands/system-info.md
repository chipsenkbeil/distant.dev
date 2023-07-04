Retrieves information about the remote system where the server is running.

| Name      | Description                                           | Example           |
| --------- | ----------------------------------------------------- | ----------------- |
| Family    | Family of the operating system (e.g. unix/windows)    | "unix"            |
| OS        | Operating system                                      | "macos"           |
| Arch      | CPU architecture                                      | "aarch64"         |
| Cwd       | Current working directory of the server               | "/path/to/dir"    |
| Path Sep  | Separator used for paths on the server                | "/"               |
| Username  | Name of the user running the server                   | "myuser"          |
| Shell     | Full path to the default shell used by the server     | "/bin/zsh"        |

??? info "distant system-info --help"

    ```
    Represents common networking configuration

    Usage: distant system-info [OPTIONS]

    Options:
          --cache <CACHE>                Location to store cached data [default: /Users/senkwich/Library/Caches/distant/cache.toml]
          --log-level <LOG_LEVEL>        Log level to use throughout the application [possible values: off, error, warn, info, debug, trace]
          --connection <CONNECTION>      Specify a connection being managed
          --log-file <LOG_FILE>          Path to file to use for logging
          --config <CONFIG_PATH>         Configuration file to load instead of the default paths
          --unix-socket <UNIX_SOCKET>    Override the path to the Unix socket used by the manager (unix-only)
          --windows-pipe <WINDOWS_PIPE>  Override the name of the local named Windows pipe used by the manager (windows-only)
      -h, --help                         Print help
    ```
