Any command can be invoked using distant, which will result in the command
being executed in the remote machine. Wrapping a command is the process of
supplying some command that you want to run, and the output is the actual
command you will run locally to map the stdin, stdout, and stderr of the remote
process to your local machine.

### plugin:wrap(opts)

This function performs a client wrapping of the given `cmd`, `lsp`, or `shell`
parameter.

```lua title="Example"
local cmd = plugin:wrap({ cmd = 'echo $PATH', shell = true })
```

Returns a string if the input is a string, or a list if the input is a list.

The function accepts a variety of arguments as part of an options table:

* `client_id`: if provided, will wrap using the specified client.

* `cmd`: wraps a regular command, which can be in the form of a single string
  or a list of strings representing the command and its arguments.

* `lsp`: wraps an LSP server command, which can be in the form of a single string
  or a list of strings representing the command and its arguments. This is
  distinct as handling language servers involves translating URIs between
  distant protocol and local `file://`.

* `shell`: wraps a regular command, which can be in the form of a boolean
  value, a single string, or a list of strings representing the command and its
  arguments. If `true` is provided, the default shell is used.
  
    In the case of `cmd` or `lsp` being provided, this is instead used to denote
    if the command should be invoked from inside a shell, using the default shell
    or an explicitly-provided shell.

* `cwd`: specifies the current working directory (as a string) for the command,
  defaulting to the server's current working directory.

* `env`: specifies environment variables in the form of a table of string ->
  string for the spawned process.

* `scheme`: if provided, uses this scheme instead of the default (lsp only).
  You really should not need to touch this parameter.

*If `client_id` is provided, will wrap using the given client; otherwise, will
use the active client. Will fail if the client is not available.*

### plugin:spawn_wrap(opts, cb)

Like `plugin:wrap`, but actually spawns the wrapped command, returning a job
object representing the wrapped command.

```lua title="Example"
local job = plugin:spawn_wrap({ cmd = 'echo $PATH', shell = true })
```

Returns a [job](../core/job) representing the spawned process.

The function accepts a variety of arguments as part of an options table:

* `client_id`: if provided, will wrap using the specified client.

* `cmd`: wraps a regular command, which can be in the form of a single string
  or a list of strings representing the command and its arguments.

* `shell`: wraps a regular command, which can be in the form of a boolean
  value, a single string, or a list of strings representing the command and its
  arguments. If `true` is provided, the default shell is used.
  
    In the case of `cmd` being provided, this is instead used to denote if the
    command should be invoked from inside a shell, using the default shell or
    an explicitly-provided shell.

* `cwd`: specifies the current working directory (as a string) for the command,
  defaulting to the server's current working directory.

* `env`: specifies environment variables in the form of a table of string ->
  string for the spawned process.

*If `client_id` is provided, will wrap using the given client; otherwise, will
use the active client. Will fail if the client is not available.*
