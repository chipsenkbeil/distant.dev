Spawns a process in a pseudo terminal (pty) and replicates it locally in a
similar manner to `ssh`.

By default, this will use the default shell associated with the server, usually
`$SHELL` on Unix platforms or `%ComSpec%` on Windows.

This can be changed by providing an alternative program to run, which could be
some other process such as `python`:

```sh
distant shell -- python
```

{{ run("distant shell --help", into_admonition=True) }}
