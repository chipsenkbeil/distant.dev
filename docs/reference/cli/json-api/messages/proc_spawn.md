Spawns a new process.

## Request

```json
{
    "type": "proc_spawn",
    "cmd": "...",
    "environment": {},
    "current_dir": "...",
    "pty": {}
}
```

### Fields

* `cmd`: the full command to execute. For example, this could be `ls -l` to
  list directories. It is up to the underlying server implementation to
  evaluate the command and split it up into individual arguments if necessary.

    Note that it is not expected that a server implementation evaluate
    environment variables in a traditional format such as `echo $PATH`. While
    implementations can differ, the base behavior is to execute the command
    as-is, meaning that evaluating environment variables may require wrapping
    the command in a shell such as `/bin/sh -c "echo $PATH"`.

* `environment`: (optional) map in the form of string -> string where the keys
  are the environment variable names and the values will be used as the values
  for those variables. This is a way to provide environment variables to
  spawned processes beyond those inherited from the server. (e.g. `{"HELLO":
  "WORLD"}`)

* `current_dir`: (optional) path to an alternative directory to use as the
  current directory for the spawned process. By default, the process will
  inherit the current working directory from the server.

* `pty`: (optional) object defining the parameters for a pseudo-terminal that
  the spawned process should be run within. Without this object, it is not
  expected that the process runs within a pseudo-terminal.

    * `rows`: number of rows (lines) for the pty. If you don't know, 80 is a
      good number to use as a default.
    * `cols`: number of columns for the pty. If you don't know, 24 is a good
      number to use as a default.
    * `pixel_width`: (optional) width of a cell in pixels. Note that some
      systems never fill this value and ignore it.
    * `pixel_height`: (optional) height of a cell in pixels. Note that some
      systems never fill this value and ignore it.

## Response

The immediate response will be a confirmation that a process was spawned with a
numeric `id` associated with the process. Note that this `id` does not
necessarily match a PID or other operating system specific id:

```json
{
    "type": "proc_spawned",
    "id": 1234
}
```

### Process stdout

As content is output to the stdout of the process, new `proc_stdout` messages
will be produced by the server:

```json
{
    "type": "proc_stdout",
    "id": 1234,
    "data": []
}
```

* `id`: same as the one provided in `proc_spawned`.
* `data`: byte array representing the output sent to the stdout of the process.
  In many cases, this can safely be converted to a UTF-8 string, but because
  not all operating systems or processes produce valid UTF-8 output, this is
  transmitted as a byte array instead.

### Process stderr

As content is output to the *stderr* of the process, new `proc_stderr` messages
will be produced by the server:

```json
{
    "type": "proc_stderr",
    "id": 1234,
    "data": []
}
```

* `id`: same as the one provided in `proc_spawned`.
* `data`: byte array representing the output sent to the stderr of the process.
  In many cases, this can safely be converted to a UTF-8 string, but because
  not all operating systems or processes produce valid UTF-8 output, this is
  transmitted as a byte array instead.

### Process done

When the process completes, a final message will be sent to indicate the result
of executing the process:

```json
{
    "type": "proc_done",
    "id": 1234,
    "success": true,
    "code": 0
}
```

* `id`: same as the one provided in `proc_spawned`.
* `success`: indicates whether or not the process exited successfully. Should
  always be included as either `true` or `false`.
* `code`: (optional) specific exit code tied to the process. This can be a
  traditional Unix exit code or (conventionally) 128 + `<signal number>`. Not
  guaranteed to be included, although for any Unix process this should be
  present.
