## Distant

Open the distant user interface.

### Usage

```
:Distant
```

## DistantCancelSearch

Cancels the active search being performed on the remote machine.

### Usage

```
:DistantCancelSearch
```

## DistantCheckHealth

Checks the health of the distant plugin.

### Usage

```
:DistantCheckHealth
```

### Notes

* This is the same as `:checkhealth distant`.

## DistantClientVersion

Prints out the version of the locally-installed distant CLI.

### Usage

```
:DistantClientVersion
```

## DistantConnect

Connects to a remote server.

### Usage

```
:DistantConnect destination [opt1=..., opt2=...]
```

Takes a `destination` as a positional argument. This can be something like
`ssh://example.com` or `distant://example.com:8080`.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `options`: additional options to use while connecting. See the [CLI
  documentation for connecting](/reference/cli/commands/connect/) for more
  details on available options.
* `log_level`: the level at which to log information about connecting. Can be
  any of 'off', 'error', 'warn', 'info', 'debug', and 'trace'.
* `log_file`: path to the file where information will be logged related to
  connecting to the destination.
* `timeout`: maximum time (in milliseconds) to wait for the connection to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the connection
  succeeded.

```title="Example"
:DistantConnect ssh://example.com options="ssh.backend=libssh,ssh.verbose=true"
```

## DistantCopy

Copies a file or directory from src to dst on the remote machine.

### Usage

```
:DistantCopy src dst [opt1=... opt2=...]
```

Takes `src` and `dst` as positional arguments. These are paths that can be
absolute or relative.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `timeout`: maximum time (in milliseconds) to wait for the operation to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the operation
  succeeded.

```title="Example"
:DistantCopy /path/to/file.txt relative/new_file.txt
```

## DistantInstall

Installs the distant CLI locally. Will provide a prompt to select between
downloading a binary, building from source, and copying a local binary to be
accessible.

### Usage

```
:DistantInstall [reinstall]
```

Takes optional `reinstall` to trigger an install even when the appropriate CLI
is already available.


## DistantLaunch

Launches a server on a remote machine and connects to it.

### Usage

```
:DistantLaunch destination [opt1=..., opt2=...]
```

Takes a `destination` as a positional argument. This can be something like
`ssh://example.com` or `manager://localhost`.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `options`: additional options to use while launching. See the [CLI
  documentation for launching](/reference/cli/commands/launch/) for more
  details on available options.
* `log_level`: the level at which to log information about launching. Can be
  any of 'off', 'error', 'warn', 'info', 'debug', and 'trace'.
* `log_file`: path to the file where information will be logged related to
  launching the server.
* `timeout`: maximum time (in milliseconds) to wait for the launching to
  succeed.
* `interval`: time (in milliseconds) between checks to see if launching
  succeeded.

```title="Example"
:DistantLaunch ssh://example.com options="distant.bin=/path/to/distant,ssh.verbose=true"
```

## DistantMetadata

Display metadata for specified path on remote machine.

### Usage

```
:DistantMetadata path [opt1=... opt2=...]
```

Takes a `path` as a positional argument. This can be something like
`/path/to/file.txt`.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `canonicalize`: if true, will resolve the file path to an absolute path with
  no relative components (`.` or `..`) and traverses symlinks to their
  referenced paths.
* `resolve_file_type`: if true, will report the underlying type pointed to by
  symlinks rather than symlink itself.
* `timeout`: maximum time (in milliseconds) to wait for retrieving metadata to
  succeed.
* `interval`: time (in milliseconds) between checks to see if retrieving
  metadata succeeded.

```title="Example"
:DistantMetadata /path/to/file.txt canonicalize=true
```

## DistantMkdir

Creates a new directory on the remote machine.

### Usage

```
:DistantMkdir path [opt1=... opt2=...]
```

Takes a `path` as a positional argument. This can be something like
`/path/to/dir`.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `all`: if true, create any missing components in the path.
* `timeout`: maximum time (in milliseconds) to wait for the operation to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the operation
  succeeded.

```title="Example"
:DistantMkdir /path/to/dir all=true
```

## DistantOpen

Open a file or directory on the remote machine.

### Usage

```
:DistantOpen [path] [opt1=... opt2=...]
```

Takes a `path` as a positional argument. This can be something like
`/path/to/file.txt`. If no path is supplied, `.` is used in its place.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `bufnr`: if provided, will use this buffer to house the opened path,
  otherwise will reuse the active buffer.
* `winnr`: if provided, will use this window to house the opened path,
  otherwise will reuse the active window.
* `line`: if provided, will jump to this line in the opened path (base 1).
* `col`: if provided, will jump to this column in the opened path (base 1).
* `client_id`: if provided, will use the client with this id instead of the
  active client to open the path.
* `reload`: if true, will reload the given path completely, re-initializing
  syntax, LSP clients, keymappings, and other settings.
* `no_focus`: if true, will not switch focus to the window housing the opened
  path.
* `timeout`: maximum time (in milliseconds) to wait for opening to succeed.
* `interval`: time (in milliseconds) between checks to see if opening
  succeeded.

```title="Example"
:DistantOpen /path/to/file.txt reload=true
```

## DistantRemove

Removes a file or directory on the remote machine.

### Usage

```
:DistantRemove path [opt1=... opt2=...]
```

Takes a `path` as a positional argument. This can be something like
`/path/to/file.txt`. *Bang is supported force removal of non-empty
directories (`:DistantRemove! path`).*

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `timeout`: maximum time (in milliseconds) to wait for the operation to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the operation
  succeeded.

```title="Example"
:DistantRemove /path/to/file.txt
```

## DistantRename

Renames a file or directory on the remote machine.

### Usage

```
:DistantRename src dst [opt1=... opt2=...]
```

Takes a `src` and `dst` as positional arguments.

Beyond the positional arguments, you can supply these optional arguments as
key-value pairs:

* `timeout`: maximum time (in milliseconds) to wait for the operation to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the operation
  succeeded.

```title="Example"
:DistantRename /path/to/file.txt /other/file.txt
```

## DistantSearch

Performs a remote search, placing matches in a quick-fix list.

### Usage

```
:DistantSearch pattern [path=...] [target=...] [opt1=... opt2=...]
```

Takes a `pattern` as a positional argument. This is a regular expression used
to find matches.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `path`: alternative path to search for the given `pattern`. By default, this
  will search `.` recursively.
* `target`: target of the search, defaulting to searching the contents of files
  for matches. Can be one of `contens` or `path`.
* `limit`: maximum results to acquire before ending the search. By default,
  this search will continue until all paths have been traversed fully.
* `max_depth`: maximum depth to traverse for results. By default, there is no
  limit.
* `follow_symlinks`: if true, will traverse symlinks when searching.
* `upward`: if true, will search up the parent paths rather than recursively
  into children.
* `timeout`: maximum time (in milliseconds) to wait for the operation to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the operation
  succeeded.

```title="Example"
:DistantSearch "hello.*" path=/some/path
```

## DistantSessionInfo

Display information about the active connection to a server.

### Usage

```
:DistantSessionInfo
```

## DistantShell

Spawns a remote shell for the current connection.

### Usage

```
:DistantShell [cmd arg1 arg2 ...]
```

Takes a series of positional arguments to represent the full command. By
default, if no command is supplied, the default shell is used.

```title="Example"
:DistantShell /usr/bin/python
```

## DistantSpawn

Executes a remote command, printing the results.

### Usage

```
:DistantSpawn cmd [arg1 arg2 ...]
```

Takes a series of positional arguments to represent the full command. The first
is used as the path to the command.

```title="Example"
:DistantSpawn echo hello
```

## DistantSystemInfo

Display information about the system of the active, connected remote server.

### Usage

```
:DistantSystemInfo
```
