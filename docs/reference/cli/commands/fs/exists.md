Checks if the path exists on the remote machine, printing out `true` or
`false` depending on the result.

```sh
distant fs exists /path/to/file.txt
```

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs exists --help", admonition="info") }}
