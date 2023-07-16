Retrieves information about the remote system where the server is running.

```sh
distant system-info
```

### Returned Information

| Name      | Description                                           | Example           |
| --------- | ----------------------------------------------------- | ----------------- |
| Family    | Family of the operating system (e.g. unix/windows)    | "unix"            |
| OS        | Operating system                                      | "macos"           |
| Arch      | CPU architecture                                      | "aarch64"         |
| Cwd       | Current working directory of the server               | "/path/to/dir"    |
| Path Sep  | Separator used for paths on the server                | "/"               |
| Username  | Name of the user running the server                   | "myuser"          |
| Shell     | Full path to the default shell used by the server     | "/bin/zsh"        |

{{ run("distant system-info --help", admonition="info") }}
