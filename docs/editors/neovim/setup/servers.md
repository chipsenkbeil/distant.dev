All settings found under the `servers` key.

```lua
local plugin = require('distant')
plugin:setup({
    servers = {}
})
```

This represents a collection of settings for servers defined by their hostname.

A key of `*` is special in that it is considered the default for all servers
and will be applied first with any host-specific settings overwriting the
default.

```lua
plugin:setup({
    servers = {
        ['*'] = {
            -- Put something in here to override defaults for all servers
        },

        ['example.com'] = {
            -- Change the current working directory and specify
            -- a path to the distant binary on the remote machine
            cwd = '/path/to/my/dir',
            launch = {
                bin = '/path/to/distant'
            },
        },
   }
})
```

### connect.default.scheme

<div class="grid" markdown>

=== "About"

    Scheme to use in place of letting distant infer an appropriate scheme.
    Use this option when you want to switch the default across all servers via
    `*` or if you want to connect in a specific way to some explicit server.

=== "Value"

    String representing the scheme (e.g. `ssh`). **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            connect = {
                default = {
                    scheme = 'ssh'
                }
            }
        }
    }
}
```

</div>

### connect.default.port

<div class="grid" markdown>

=== "About"

    Port to use when connecting.

=== "Value"

    Integer representing the port. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            connect = {
                default = {
                    port = 8080
                }
            }
        }
    }
}
```

</div>

### connect.default.username

<div class="grid" markdown>

=== "About"

    Username to use when connecting.

=== "Value"

    String representing the username. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            connect = {
                default = {
                    username = 'my-username'
                }
            }
        }
    }
}
```

</div>

### connect.default.options

<div class="grid" markdown>

=== "About"

    Options to pass along to distant when connecting. See the [CLI
    documentation for connecting](/reference/cli/commands/connect/) for more
    details on available options.

=== "Value"

    String representing a comma-separated list of options. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            connect = {
                default = {
                    options = 'key=1234,ssh.backend=libssh'
                }
            }
        }
    }
}
```

</div>

### cwd

<div class="grid" markdown>

=== "About"

    !!! warning

        This is not yet implemented, but is a placeholder for this feature!

    If specified, will apply the current working directory to any cases of
    spawning processes, opening directories & files, starting shells, and
    wrapping commands.

    Will be overwritten if an explicit `cwd` or absolute path is provided in
    those situations.

=== "Value"

    String representing the path. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            cwd = '/path/to/dir'
        }
    }
}
```

</div>

### launch.default.scheme

<div class="grid" markdown>

=== "About"

    Scheme to use in place of letting distant infer an appropriate scheme.
    Use this option when you want to switch the default across all servers via
    `*` or if you want to launch in a specific way to some explicit server.

=== "Value"

    String representing the scheme (e.g. `ssh`). **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    scheme = 'ssh'
                }
            }
        }
    }
}
```

</div>

### launch.default.port

<div class="grid" markdown>

=== "About"

    Port to use when launching.

=== "Value"

    Integer representing the port. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    port = 8080
                }
            }
        }
    }
}
```

</div>

### launch.default.username

<div class="grid" markdown>

=== "About"

    Username to use when launching.

=== "Value"

    String representing the username. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    username = 'my-username'
                }
            }
        }
    }
}
```

</div>

### launch.default.bin

<div class="grid" markdown>

=== "About"

    Path to distant binary on remote machine. This is particularly useful to
    refer to distant when it is not on your path or launching is unable to find
    the distant binary.

=== "Value"

    String representing the path to the binary. **[default: distant]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    bin = '/path/to/distant'
                }
            }
        }
    }
}
```

</div>

### launch.default.args

<div class="grid" markdown>

=== "About"

    Additional arguments to pass to the server when starting it on the remote
    machine. This is useful when you want to specify configurations like
    shutting down after N seconds, specifying a custom port to listen on, or
    providing a custom logging path.

    Run `distant server listen --help` to see available arguments.

=== "Value"

    String representing the arguments. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    args = '--port 8080 --shutdown after=3600 --log-level trace'
                }
            }
        }
    }
}
```

</div>

### launch.default.options

<div class="grid" markdown>

=== "About"

    Options to pass along to distant when launching. See the [CLI
    documentation for launching](/reference/cli/commands/launch/) for more
    details on available options.

=== "Value"

    String representing a comma-separated list of options. **[default: ]**

```lua title="Example"
{
    servers = {
        ['*'] = {
            launch = {
                default = {
                    options = 'key=1234,ssh.backend=libssh'
                }
            }
        }
    }
}
```

</div>

## Language Servers

Language servers can be configured with distant by using the `lsp` key, which
is a mapping of a label (this can be anything) to language server settings.

```lua
{
    servers = {
        ['*'] = {
            lsp = {
                ['My Project'] = {
                    cmd = '/path/to/lsp-server',
                    root_dir = '/path/to/project',
                    file_types = {'rust'},
                    on_exit = function(code, signal, client_id)
                        local prefix = '[Client ' .. tostring(client_id) .. ']'
                        print(prefix .. ' LSP exited with code ' .. tostring(code))

                        -- Signal can be nil
                        if signal ~= nil then
                            print(prefix .. ' Signal ' .. tostring(signal))
                        end
                    end,
                }
            }
        }
    }
}
```

### lsp.*.cmd

<div class="grid" markdown>

=== "About"

    Sets the command to be invoked as the language server. This command is run
    on the remote machine, not the local machine. This is a **required** field
    for each defined language server.

=== "Value"

    String or list of strings representing the command to execute.

```lua title="Example"
{
    servers = {
        ['*'] = {
            lsp = {
                ['My Project'] = {
                    cmd = '/path/to/lsp --arg'
                }
            }
        }
    }
}
```

</div>

### lsp.*.root_dir

<div class="grid" markdown>

=== "About"

    Root directory where the language server will operate. This should
    typically match the root directory of a project. This is a **required**
    field for each defined language server.

=== "Value"

    String, list of strings, or a function.

    In the case of a string or list of strings, each is treated as a root path,
    and any file opened will be checked to see if it is contained within the
    path. If so, a client is established with the associated language server.

    If a function, it will be invoked with the file path and buffer number
    whenever a file is opened. The function returns a path to the file to be
    connected to a language server (if relevant), or nil if not applicable.

```lua title="Example"
{
    servers = {
        ['*'] = {
            lsp = {
                ['My Project'] = {
                    root_dir = function(path, _bufnr)
                        -- Only allow if within a specific directory
                        if vim.startswith(path, '/my/project/dir') then
                            return path
                        end
                    end
                }
            }
        }
    }
}
```

</div>

### lsp.*.file_types

<div class="grid" markdown>

=== "About"

    Optional list of file types to specifically target with this language
    server. If not provided, will apply to all file types.

=== "Value"

    List of strings, each representing a file type.

```lua title="Example"
{
    servers = {
        ['*'] = {
            lsp = {
                ['My Project'] = {
                    file_types = {'rust'}
                }
            }
        }
    }
}
```

</div>

### lsp.*.on_exit

<div class="grid" markdown>

=== "About"

    Optional function to be triggered when a language server on the remote
    machine exits.

=== "Value"

    Function taking an exit code, signal (can be nil), and client id as
    arguments.

```lua title="Example"
{
    servers = {
        ['*'] = {
            lsp = {
                ['My Project'] = {
                    on_exit = function(code, signal, client_id)
                        local prefix = '[Client ' .. tostring(client_id) .. ']'
                        print(prefix .. ' LSP exited with code ' .. tostring(code))

                        -- Signal can be nil
                        if signal ~= nil then
                            print(prefix .. ' Signal ' .. tostring(signal))
                        end
                    end,
                }
            }
        }
    }
}
```

</div>
