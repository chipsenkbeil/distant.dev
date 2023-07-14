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

### Supporting environment variables

If you try to use environment variables when spawning a process, you may notice
that they do not work as expected:

```sh
# This echoes "$PATH" instead of evaluating it
distant spawn -c 'echo $PATH'
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
distant spawn -c 'echo $PATH' --shell
```

{{ asciinema("/assets/videos/spawning-with-shell.cast") }}

{{ run("distant spawn --help", admonition="info") }}
