Retrieves information about the remote system.

## Request

```json
{
    "type": "system_info"
}
```

## Response

```json
{
    "type": "system_info",
    "family": "...",
    "os": "...",
    "arch": "...",
    "current_dir": "...",
    "main_separator": "...",
    "username": "...",
    "shell": "..."
}
```

### Fields

* `family`: family of the operating system as described in
  [`std::env::consts::FAMILY`](https://doc.rust-lang.org/std/env/consts/constant.FAMILY.html).

* `os`: name of the specific operating system as described in
  [`std::env::consts::OS`](https://doc.rust-lang.org/std/env/consts/constant.OS.html).

* `arch`: architecture of the CPU as described in
  [`std::env::consts::ARCH`](https://doc.rust-lang.org/std/env/consts/constant.ARCH.html).

* `current_dir`: current working directory of the running server process.

* `main_separator`: Primary separator for path components for the current
  platform as defined in
  [`std::path::MAIN_SEPARATOR`](https://doc.rust-lang.org/std/path/constant.MAIN_SEPARATOR.html).

* `username`: name of the user running the server process.

* `shell`: default shell tied to user running the server process.

### Notes

* While every field is required to be returned, some implementations such as
  `ssh` may not have access to all information easily. So the expectation is a
  *best possible* approach to returning data. For anything unavailable, you can
  expect an empty string, rather than an undefined value in JSON.

