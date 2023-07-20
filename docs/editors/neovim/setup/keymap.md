All settings found under the `keymap` key.

```lua
local plugin = require('distant')
plugin:setup({
   keymap = {}
})
```

### keymap.dir.enabled

<div class="grid" markdown>

=== "About"

    Indicates if assigning keymaps to directories opened with distant is
    enabled. When `true`, whenever a buffer is created that represents a
    directory on a remote machine managed by distant, keymappings defined
    for remote directories are applied to the buffer.

=== "Value"

    Boolean representing directory keymappings being enabled. **[default:
    true]**

```lua title="Example"
{
    keymap = {
        dir = {
            enabled = false
        }
    }
}
```

</div>

### keymap.dir.copy

<div class="grid" markdown>

=== "About"

    Keymap to use for copying a file or directory under cursor in a directory
    buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "C"]**
    
    *Note this is `<Shift-C>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            copy = 'C'
        }
    }
}
```

</div>

### keymap.dir.edit

<div class="grid" markdown>

=== "About"

    Keymap to use for opening a file or directory under cursor in a directory
    buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "<Return>"]**

```lua title="Example"
{
    keymap = {
        dir = {
            edit = '<Return>'
        }
    }
}
```

</div>

### keymap.dir.metadata

<div class="grid" markdown>

=== "About"

    Keymap to use for opening metadata about a file or directory under cursor
    in a directory buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "M"]**
    
    *Note this is `<Shift-M>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            metadata = 'M'
        }
    }
}
```

</div>

### keymap.dir.newdir

<div class="grid" markdown>

=== "About"

    Keymap to use for creating a new directory in a directory buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "K"]**
    
    *Note this is `<Shift-K>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            newdir = 'K'
        }
    }
}
```

</div>

### keymap.dir.newfile

<div class="grid" markdown>

=== "About"

    Keymap to use for creating a new file in a directory buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "N"]**
    
    *Note this is `<Shift-N>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            newfile = 'N'
        }
    }
}
```

</div>

### keymap.dir.rename

<div class="grid" markdown>

=== "About"

    Keymap to use for renaming a file or directory under cursor in a directory
    buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "R"]**
    
    *Note this is `<Shift-R>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            rename = 'R'
        }
    }
}
```

</div>

### keymap.dir.remove

<div class="grid" markdown>

=== "About"

    Keymap to use for removing a file or directory under cursor in a directory
    buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "D"]**
    
    *Note this is `<Shift-D>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        dir = {
            remove = 'D'
        }
    }
}
```

</div>

### keymap.dir.up

<div class="grid" markdown>

=== "About"

    Keymap to use for moving up to the parent directory in a directory buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "-"]**

```lua title="Example"
{
    keymap = {
        dir = {
            up = '-'
        }
    }
}
```

</div>

### keymap.file.enabled

<div class="grid" markdown>

=== "About"

    Indicates if assigning keymaps to files opened with distant is enabled.
    When `true`, whenever a buffer is created that represents a file on a
    remote machine managed by distant, keymappings defined for remote files are
    applied to the buffer.

=== "Value"

    Boolean representing file keymappings being enabled. **[default: true]**

```lua title="Example"
{
    keymap = {
        file = {
            enabled = false
        }
    }
}
```

</div>

### keymap.file.up

<div class="grid" markdown>

=== "About"

    Keymap to use for moving up to the parent directory in a file buffer.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "-"]**

```lua title="Example"
{
    keymap = {
        file = {
            up = '-'
        }
    }
}
```

</div>

### keymap.ui.exit

<div class="grid" markdown>

=== "About"

    Keymap to use for exiting an open window in the UI.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "q" or `<Esc>`]**

```lua title="Example"
{
    keymap = {
        ui = {
            exit = {'q', '<Esc>'}
        }
    }
}
```

</div>

### keymap.ui.main.connections.kill

<div class="grid" markdown>

=== "About"

    Keymap to use for killing the connection under cursor from within the
    connections tab of the main UI window opened using `:Distant`.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "K"]**

    *Note this is `<Shift-K>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                connections = {
                    kill = 'K'
                }
            }
        }
    }
}
```

</div>

### keymap.ui.main.connections.toggle_info

<div class="grid" markdown>

=== "About"

    Keymap to use for toggling more information about the connection under
    cursor from within the connections tab of the main UI window opened using
    `:Distant`.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "I"]**

    *Note this is `<Shift-I>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                connections = {
                    toggle_info = 'I'
                }
            }
        }
    }
}
```

</div>

### keymap.ui.main.tabs.goto_connections

<div class="grid" markdown>

=== "About"

    Keymap to use for navigating to the connections tab within the main UI
    window opened using `:Distant`.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "1"]**

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                tabs = {
                    goto_connections = '1'
                }
            }
        }
    }
}
```

</div>

### keymap.ui.main.tabs.goto_system_info

<div class="grid" markdown>

=== "About"

    Keymap to use for navigating to the system info tab within the main UI
    window opened using `:Distant`.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "2"]**

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                tabs = {
                    goto_system_info = '2'
                }
            }
        }
    }
}
```

</div>

### keymap.ui.main.tabs.goto_help

<div class="grid" markdown>

=== "About"

    Keymap to use for navigating to the help tab within the main UI window
    opened using `:Distant`.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "?"]**

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                tabs = {
                    goto_help = '?'
                }
            }
        }
    }
}
```

</div>

### keymap.ui.main.tabs.refresh

<div class="grid" markdown>

=== "About"

    Keymap to use for refreshing the content within the main UI window opened
    using `:Distant` for the current tab.

=== "Value"

    String or list of strings where each string represents a key combination
    that can be performed to trigger the action. **[default: "R"]**

    *Note this is `<Shift-R>` to trigger the action.*

```lua title="Example"
{
    keymap = {
        ui = {
            main = {
                tabs = {
                    refresh = 'R'
                }
            }
        }
    }
}
```

</div>
