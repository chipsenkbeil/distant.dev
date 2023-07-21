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

Takes a `destination` as the positional argument. This can be something like
`ssh://example.com` or `distant://example.com:8080`.

Beyond the positional argument, you can supply these optional arguments as
key-value pairs:

* `timeout`: maximum time (in milliseconds) to wait for the connection to
  succeed.
* `interval`: time (in milliseconds) between checks to see if the connection
  succeeded.
* `log_level`: the level at which to log information about connecting. Can be
  any of 'off', 'error', 'warn', 'info', 'debug', and 'trace'.
* `log_file`: path to the file where information will be logged related to
  connecting to the destination.
* `options`: additional options to use while connecting. See the [CLI
  documentation for connecting](/reference/cli/commands/connect/) for more
  details on available options.

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

* `timeout`: maximum time (in milliseconds) to wait for the copy to succeed.
* `interval`: time (in milliseconds) between checks to see if the copy
  succeeded.

```title="Example"
:DistantCopy /path/to/file.txt relative/new_file.txt
```
