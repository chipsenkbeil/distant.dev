Writes the contents to a file on the remote machine.

```sh
distant fs write /path/to/file.txt 'hello world'
```

### Flags

* `--append`: indicates to append the contents to the file rather than
  overwrite it. If the file does not exist, it is created.

### Examples

#### Piping content into a file

In the absence of a content positional argument, *stdin* will be read until EOF
is received, and then used as the content for the file:

```sh
echo 'some text' | distant fs write /path/to/file.txt
```

#### Appending content to a file

If you provide the `append` flag, then all content is appended instead of
overwriting the file:

```sh
distant fs write --append /path/to/file.txt 'some text'
```

### Notes

* If no contents are provided, then the contents are read from *stdin*.
* Relative paths resolve to the current working directory of the server.

{{ run("distant fs watch --help", admonition="info") }}
