Searches the filesystem on the remote machine.

```sh
distant fs search 'hello.*'
```

### Flags

* `--target <TARGET>`: indicates whether to search paths or the contents of
  files. `--target path` will search paths whereas `--target contents` will
  search the contents of files. By default, this searches the contents of
  files.
* `--include <REGEX>`: specifies additional regex to use to limit which paths
  are searched to only those that match the given regex.
* `--exclude <REGEX>`: specifies additional regex to use to limit which paths
  are searched to only those that do not match the given regex.
* `--upward`: indicates that we should search upward versus recursively
  downward. What this does is search the target and then moves up to the parent
  directory and searches its immediate children. This continues until either a
  match is found or the depth is reached.
* `--follow-symbolic-links`: indicates that symbolic links will be traversed
  while searching. By default, they are not traversed.
* `--limit <N>`: indicates to stop searching after N results are found. By
  default, there is no limit when searching.
* `--max-depth <MAX>`: indicates the maximum depth to search (recursively or
  upward) with 0 meaning only the current file (or directory when upward).
* `--pagination <N>`: indicates how many results to match during a search
  before printing them. By default, a search will wait until finished before
  printing results.
* `--ignore-hidden`: indicates that hidden files will be skipped when
  searching. On Unix systems, hidden files and folders are denoted with a dot
  in front of their name such as `.hidden.txt`.
* `--use-ignore-files`: will read `.ignore` files that are used by `ripgrep`
  and `The Silver Searcher` to determine which files and directories ignore.
* `--use-parent-ignore-files`: will read `.ignore` files from parent
  directories that are used by `ripgrep` and `The Silver Searcher` to determine
  which files and directories to ignore.
* `--use-git-ignore-files`: will read `.gitignore` files to determine which
  files and directories to ignore. 
* `--use-global-git-ignore-files`: will read global `.gitignore` files to
  determine which files and directories to ignore. 
* `--use-git-exclude-files`: will read `.git/info/exclude` files to determine
  which files and directories to ignore.

### Examples

#### Explicit Path

Typically, searching is best limited to a specific directory, such as a
specific project on a remote machine:

```sh
distant fs search 'hello.*' /path/to/project
```

#### Behave like ripgrep

Ripgrep provides a lot of exclusions out of the box when searching to avoid
looking at unnecessary files. Distant does not enable any of those restrictions
by default, so to match ripgrep, you should provide the following flags:

```sh
distant fs search \
    --ignore-hidden \
    --use-ignore-files \
    --use-parent-ignore-files \
    --use-git-ignore-files \
    --use-global-git-ignore-files \
    --use-git-exclude-files \
    'hello.*'
```

#### Looking for a match upward

When trying to determine if you are in a project directory, a common practice
is to look for a specific file such as a `Cargo.toml`. An easy way to do this
is to use `--upward` alongside `--limit 1` with a `path` target to find the
file if it exists:

```sh
distant fs search \
    --upward \
    --limit 1 \
    --target path \
    'Cargo.toml'
```

### Notes

* Relative paths resolve to the current working directory of the server.
* If no explicit paths are provided, this will search the current working
  directory.

{{ run("distant fs search --help", admonition="info") }}
