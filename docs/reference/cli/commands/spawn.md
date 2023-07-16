Spawns a process on the remote machine. There are two different ways to
use this command:

1. Providing a `--` to signify the start of the command and its arguments. This
   is useful when you want to pass everything from a shell naturally.

    ```sh
    distant spawn -- echo hello
    ```

2. Providing a `-c <STR>` argument where a string argument is used to signify
   the command and its arguments. This can be useful when passing around a
   command from scripts.

    ```sh
    distant spawn -c "echo hello"
    ```

### Flags

* `--cmd <CMD>`: will spawn the specified command. This is an alternative
  syntax to using `--` as described above, and can aid in providing commands
  without evaluating environment variables locally.

* `--current-dir <DIR>`: provide an alternative directory to use as the current
  working directory for the spawned process. By default, the process will
  inherit the working directory of the server.

* `--environment <ENV>`: provide environment variables to be available in the
  process when spawned. These are comma-separated in a `KEY=VALUE` format.

* `--lsp <SCHEME>`: captures stdin and stdout of the process, evaluates it as
  language server protocol messages, and translates any file references that
  use `file://` into `distant://` (or the custom `scheme`) and vice versa. This
  is needed when working with language servers to ensure that they can properly
  detect and work with files while allowing the local machine to operate on
  them using the `distant` scheme.

* `--pty`: starts the process using a pseudo terminal. This is normally what
  `distant shell` will do, and the dimensions of the pseudo terminal are
  calculated from the current terminal used to execute `distant spawn ...`.

* `--shell [<SHELL>]`: if specified, will spawn the process in the specified
  shell, defaulting to the user-configured shell.

### Supporting environment variables

If you try to use environment variables when spawning a process, you may notice
that they do not work as expected:

```sh
# This echoes "$PATH" instead of evaluating it
distant spawn --cmd 'echo $PATH'
```

This is due to how spawning a process works on the server. By default, spawning
a process results in directly invoking `fork` and `exec` on Unix platforms or
`CreateProcess` on Windows. These calls do not leverage a shell and thereby do
not expand parameters into values such as `$PATH`.

In order to use a shell to execute the process, you can use `--shell` to
leverage the default shell available to the running distant server tied to the
user who started the server, or `--shell <SHELL>` to specify the path to an
explicit shell to use.

```sh
# This evaluates and echoes the path
distant spawn --cmd 'echo $PATH' --shell
```

{{ asciinema("/assets/videos/spawning-with-shell.cast") }}

### Examples

#### Supplying custom environment variables

Similar to other multi-option flags, the `environment` option takes a
collection of environment variables in the form of `KEY=VALUE`. Note that to
evaluate these environment variables in a shell expression, you need to also
include the `shell` flag:

```sh
distant spawn --cmd 'echo $VAR' --shell --environment 'VAR="hello world",KEY=value'
```

{{ run("distant spawn --help", admonition="info") }}
