As distant supports shells that give you full access to the remote
machine, you can spawn a shell inside a neovim buffer by using the
`spawn_shell` function:

```lua title="Example"
plugin:spawn_shell()
```

The function accepts a variety of arguments as part of an options table:

* `bufnr`: specifies the buffer to use. If -1, will create a new buffer.
  Default is -1.
* `winnr`: specifies the window to use. Default is current window.
* `cmd`: is the optional command to use instead of the server's default shell.
  Can be either a string or a list of strings representing the command and its
  arguments.
* `cwd`: is the optional current working directory to set for the shell when
  spawning it.
* `env`: is the optional map of environment variable values to supply to the
  shell. This is a table of key-value pairs.

```lua title="Example"
plugin:spawn_shell({
  cmd = '/usr/local/python',
  env = {
    ['MYVAR'] = 'abcd',
  },
})
```
