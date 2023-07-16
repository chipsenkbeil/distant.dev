The distant CLI provides a variety of commands that cover client interactions,
server usage, manager operations and servers, and generating files.

### Flags

All commands support these flags:

* `--config <FILE>`: alternative path to a config file to use. Default varies
  by operating system. See the [config section](/reference/cli/config/) for
  more details.
* `--log-file <FILE>`: path to the file where events should be logged. By
  default, no file is created.
* `--log-level <LEVEL>`: the level at which to log events. Supports *off*,
  *error*, *warn*, *info*, *debug*, and *trace*. By default, this is *info*.

Most commands support these flags:

* `--cache <FILE>`: alternative location for a cache file where distant stores
  information like the currently-selected connection.
* `--connection <ID>`: the id of the connection to communicate with from the
  active distant manager. This enables communicating with a specific
  connection regardless of the cached, selected connection.
* `--unix-socket <FILE>`: alternative path to the Unix domain socket to use
  for communication with the distant manager. This flag is used both to specify
  the socket when starting a manager and pointing to the socket when connecting
  to a manager for many commands. (Unix only)
* `--windows-pipe <FILE>`: alternative pipe name for the named Windows pipe to
  use for communication with the distant manager. This flag is used both to
  specify the socket when starting a manager and pointing to the socket when
  connecting to a manager for many commands. (Windows only)

{{ run("distant --help", admonition="info") }}
