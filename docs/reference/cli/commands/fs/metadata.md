Retrieves metadata about a path on the remote machine.

```sh
distant fs metadata /path/to/file.txt
```

### Flags

* `--canonicalize`: resolves relative paths and evaluate and follow symlinks to
  determine the absolute path to the underlying file or directory.
* `--resolve-file-type`: changes the returned file type from symlinks to the
  underlying file or directory types. If not provided, this will report the
  type of the immediate path.

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs metadata --help", admonition="info") }}
