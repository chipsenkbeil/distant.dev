Copies a file or directory on the remote machine to a new destination.

```sh
distant fs copy /path/to/file.txt /new/path/to/file.txt
```

### Notes

* Directories have their entire contents recursively copied to the destination.
* Relative paths resolve to the current working directory of the server.

{{ run("distant fs copy --help", admonition="info") }}
