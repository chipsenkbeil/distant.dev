Renames the file or directory on the remote machine.

```sh
distant fs rename /path/to/file.txt /path/to/new.txt
```

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs rename --help", admonition="info") }}
