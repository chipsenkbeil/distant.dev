Starts a server that implements the distant protocol.

```sh
distant server listen
```

### Flags

* `--current-dir <DIR>`: changes the current working directory of the server,
     which is normally set to its parent process' directory.

* `--daemon`: runs the server process as a daemon, meaning that it is detached
     from the parent process and will continue running even after the parent
     exits. On Unix systems this involves `fork` while on Windows this uses
     `CreateProcess` in a detached state.

* `--host <HOST>`: used to bind the server to restrict communication over a
     specific network interface. This can be `ssh`, `any`, or a specific IP
     address representing the interface like `192.168.1.123`.

     In the case of `ssh`, the `SSH_CONNECTION` environment variable will be
     parsed to bind to the associated interface. This variable is usually present
     during an ssh session on the connected machine, and is leveraged by default
     when using `distant launch` to start the server.

     In the case of `any`, the server will bind to `0.0.0.0` to support receiving
     traffic from any network interface.

* `--key-from-stdin`: stops the server from generating an authentication key
     and instead uses the key provided over stdin. The key is contained over
     the next 32 bytes of stdin. Receiving less than 32 bytes is an error and
     any bytes beyond the first 32 are ignored.

* `--port <PORT[:PORT2]>`: used to specify an explicit port or range of ports
     for the server to attempt to use for listening over TCP. By default, the
     server will leverage the operating system to provide it an open port
     (ephemeral port).
     
     A port can be specified either singularly (`8080`) or as a range
     (`8080:8089`).

* `--shutdown <RULE>`: indicates whether the server should shutdown based on
     some logic. The available options are:

      * `never`: the server will never shutdown on its own.
      * `after=N`: the server will shutdown after `N` seconds.
      * `lonely=N`: the server will shutdown after `N` seconds with no active
        connection.

* `--use-ipv6`: indicates that the server should listen on an IPv6 network
     address versus an IPv4 one. For a host of `any`, this results in binding to
     `[::]`.

* `--watch-compare-contents`: will attempt to load a file and compare its
     contents to detect file changes, only relevant when using the polling 
     watcher implementation (VERY SLOW).

* `--watch-debounce-tick-rate <N>`: how often (in seconds) to check for new
     events before the debounce timeout occurs. Defaults to 1/4 the debounce
     timeout if not set.

* `--watch-debounce-timeout <N>`: maximum time (in seconds) to wait for
     filesystem changes before reporting them, which is useful to avoid noisy
     changes as well as serves to consolidate different events that represent
     the same action.

* `--watch-polling`: configures the server to use a polling method to watch for
     filesystem changes instead of the default, native poller.

* `--watch-polling-interval <N>`: adjusts the time between checks of filesystem
     changes by the polling filesystem watcher.

### Examples

#### Spawning a server that is long-lived

Typically, you want to spawn a server that will run after your shell has
exited. Given that you cannot see any output, you also want to redirect logging
to a file via `log-file`:

```sh
distant server listen --daemon --log-file /path/to/server.log
```

{{ run("distant server listen --help", admonition="info") }}
