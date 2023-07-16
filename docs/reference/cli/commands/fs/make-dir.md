Creates a directory on the remote machine.

```sh
distant fs make-dir /path/to/dir
```

### Flags

* `--all`: will create any of the missing intermediate directories in the path.
  If not provided, the call will fail if there is a missing part of the path.

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs make-dir --help", admonition="info") }}
