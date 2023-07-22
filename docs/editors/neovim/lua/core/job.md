A job is a specialized Lua table that tracks the ongoing status of a remote
process and provides mechanisms to both write to the stdin and retrieve the
stdout and stderr of the process.

### job:id()

Returns the number representing the id of the job if it is running; otherwise,
this function will fail.

### job:is_running()

Returns `true` if the job is still running, otherwise `false`.

### job:stdout_lines()

Returns a list of strings representing the lines of stdout received for the
remote process. This is only populated if the job is buffering its stdout.

### job:stderr_lines()

Returns a list of strings representing the lines of stderr received for the
remote process. This is only populated if the job is buffering its stderr.

### job:exit_status()

Returns the exit status of the job if it has completed, otherwise will be
`nil`.

The exit status is a table comprised of these fields:

* `success`: a boolean indicating whether the process succeeded or failed.
* `exit_code`: the exit code tied to the process.
* `signal`: if the exit code corresponds to a signal, then this is populated
  with the signal's number as described in POSIX.
* `stdout`: a list of strings representing the stdout of the process over its
  lifetime. This is only populated if the job is buffering its stdout.
* `stderr`: a list of strings representing the stderr of the process over its
  lifetime. This is only populated if the job is buffering its stderr.

### job:write(data)

Writes `data` to the remote process by feeding it as stdin to the local proxy
job. `data` may be a string, string convertible, blob, or a list of strings
that will be joined by newline characters.

Returns the number of bytes written or 0 if writing failed.

### job:stop()

Stops the local job, which in turn may or *may not* kill the remote process.
