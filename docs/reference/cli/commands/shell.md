Spawns a process in a pseudo terminal (pty) and replicates it locally in a
similar manner to `ssh`.

```sh
distant shell
```

### Flags

* `--current-dir <DIR>`: provide an alternative directory to use as the current
  working directory for the spawned shell. By default, the shell will inherit
  the working directory of the server.

* `--environment <ENV>`: provide environment variables to be available in the
  shell when spawned. These are comma-separated in a `KEY=VALUE` format.

### Examples

#### Using a custom shell

By default, this will use the default shell associated with the server, usually
`$SHELL` on Unix platforms or `%ComSpec%` on Windows.

This can be changed by providing an alternative program to run, which could be
some other process such as `python`:

```sh
distant shell -- python
```

#### Supplying custom environment variables

Similar to other multi-option flags, the `environment` option takes a
collection of environment variables in the form of `KEY=VALUE`:

```sh
distant shell --environment 'VAR="hello world",KEY=value'
```

{{ run("distant shell --help", admonition="info") }}
