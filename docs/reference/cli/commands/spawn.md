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

{{ run("distant spawn --help", admonition="info") }}
