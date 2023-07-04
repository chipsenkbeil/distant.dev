Retrieves version information of the remote server.

| Name              | Description                                                               | Example           |
| ----------------- | ------------------------------------------------------------------------- | ----------------- |
| Server Version    | The version of the server                                                 | 0.20.0            |
| Protocol Version  | The version of the protocol (different servers can have same protocol)    | 0.1.0             |
| Capabilities      | What features the server has implemented                                  | "search"          |

??? info "distant version --help"

    ```
    Retrieves version information of the remote server

    Usage: distant version [OPTIONS]

    Options:
          --cache <CACHE>
              Location to store cached data

              [default: /Users/senkwich/Library/Caches/distant/cache.toml]

          --log-level <LOG_LEVEL>
              Log level to use throughout the application

              [possible values: off, error, warn, info, debug, trace]

          --connection <CONNECTION>
              Specify a connection being managed

          --log-file <LOG_FILE>
              Path to file to use for logging

          --config <CONFIG_PATH>
              Configuration file to load instead of the default paths

          --unix-socket <UNIX_SOCKET>
              Override the path to the Unix socket used by the manager (unix-only)

          --windows-pipe <WINDOWS_PIPE>
              Override the name of the local named Windows pipe used by the manager (windows-only)

      -f, --format <FORMAT>
              [default: shell]

              Possible values:
              - json:  Sends and receives data in JSON format
              - shell: Commands are traditional shell commands and output responses are inline with what is expected of a program's output in a shell

      -h, --help
              Print help (see a summary with '-h')
    ```
