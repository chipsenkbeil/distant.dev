Reads the contents of a file or directory on the remote machine.

```sh
distant fs read /path/to/file.txt
```

### Flags

* `--depth`: determines how many levels deep to traverse when printing out a
  directory's contents. By default this is 1, meaning to traverse the
  directory's children only (similar to `ls`).
* `--absolute`: resolves relative paths when printing out a directory's
  contents. This does NOT traverse symlinks.
* `--canonicalize`: resolves relative paths and traverses symlinks when
  printing out a directory's contents.
* `--include-root`: includes the directory itself when printing a directory's
  contents.

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs read --help", admonition="info") }}
