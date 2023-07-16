Removes the file or directory on the remote machine.

```sh
distant fs remove /path/to/file.txt
```

### Flags

* `--force`: if provided, will remove non-empty directories.

### Notes

* This command will fail if provided a non-empty directory unless the `force`
  flag is specified.
* Relative paths resolve to the current working directory of the server.

{{ run("distant fs remove --help", admonition="info") }}
