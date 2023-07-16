Starts a distant manager listening for new actions to perform.

```sh
distant manager listen
```

### Flags

* `--access <ACCESS>`: type of access to apply to created unix socket or windows pipe.

    * **owner**: equates to `0o600` on Unix (read & write for owner).
    * **group**: equates to `0o660` on Unix (read & write for owner and group).
    * **anyone**: equates to `0o666` on Unix (read & write for owner, group,
      and other).

* `--daemon`: runs the manager process as a daemon, meaning that it is detached
  from the parent process and will continue running even after the parent
  exits. On Unix systems this involves `fork` while on Windows this uses
  `CreateProcess` in a detached state.

* `--user`: will listen on a user-local Unix domain socket (UDS) or local named
  Windows pipe. Normally, distant will attempt to create a UDS in a
  globally-accessible area or establish a global pipe.

{{ run("distant manager listen --help", admonition="info") }}
