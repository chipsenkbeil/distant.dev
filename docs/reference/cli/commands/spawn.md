Spawns a process on the remote machine. There are two different ways to
use this command:

1. Providing a `--` to signify the start of the command and its arguments. This
   is useful when you want to pass everything from a shell naturally.

    ```sh
    distant spawn -- echo hello
    ```

2. Providing a `-c <STR>` argument where a string argument is used to signify
   the command and its arguments. This can be useful when passing around a
   command from scripts.

    ```sh
    distant spawn -c "echo hello"
    ```

??? info "distant spawn --help"

    ```
    Spawn a process on the remote machine

    Usage: distant spawn [OPTIONS] [-- <CMD>...]

    Arguments:
      [CMD]...
              Command to run

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

          --lsp [<SCHEME>]
              If specified, will assume the remote process is a LSP server and will translate paths that are local into `distant` and vice versa.

              If a scheme is provided, will translate local paths into that scheme!

          --pty
              If specified, will spawn process using a pseudo tty

          --current-dir <CURRENT_DIR>
              Alternative current directory for the remote process

          --environment <ENVIRONMENT>
              Environment variables to provide to the shell

              [default: ]

      -c, --cmd <CMD_STR>
              If present, commands are read from the provided string

      -h, --help
              Print help (see a summary with '-h')
    ```
