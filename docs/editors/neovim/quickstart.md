## 1. Add the distant plugin to neovim

Install [distant.nvim](https://github.com/chipsenkbeil/distant.nvim) using your
favorite neovim plugin manager. Below are a few examples of package managers
that you can use to install and setup distant.

### Using [lazy](https://github.com/folke/lazy.nvim)

```lua
{
    'chipsenkbeil/distant.nvim', 
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
}
```

### Using [packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
}
```

### Using [plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'chipsenkbeil/distant.nvim', {
\ 'branch': 'v0.3',
\ 'do': ':lua require("distant"):setup()'
\ }
```

## 2. Install distant on your local machine

!!! note

    If you already have `distant` installed with a version that is compatible
    with the plugin, this step can be skipped. You can verify if distant is
    installed correctly by running `:checkhealth distant`.

Using the plugin, you can execute this command:

```
:DistantInstall
```

A prompt will be provided where you can download a pre-built binary for your
local machine that will be placed in `~/.local/share/nvim/distant/` on Unix
systems or `~\AppData\Local\nvim-data\distant/` on Windows.

You can verify that it is available by running `:DistantClientVersion`.

See the [neovim installation guide](../installation) for more information.

## 3. Install distant on your remote machine

!!! note

    If you want to just use distant to connect to an ssh server, you can skip
    this and the remaining steps and use `:DistantConnect ssh://example.com`.

Log into your remote machine and run this command to download a script to run
to install distant. In this example, we'll use ssh to install distant on a
Unix-compatible server (example.com):

```
ssh example.com 'curl -L https://sh.distant.dev | sh -s -- --on-conflict overwrite'
```

See the [distant CLI installation guide](/getting-started/installation) for
more information.

## 4. Launch and connect to distant on your remote machine

Now that `distant` is available on both your local and remote machine, you can
start a server and connect to it all in one step using this command:

```
:DistantLaunch ssh://example.com
```

This will do the following:

1. Log into `example.com` on port `22` using ssh
2. Start the distant server on an open TCP port using `distant server listen
   --daemon`
3. Disconnect from the ssh server
4. Connect to `example.com` on the bound TCP port of the distant server

!!! note

    If you want more control over the port used by distant, you can provide an
    additional argument to `DistantLaunch` to spawn the server on the specified
    port such as this example to run distant on port `8080`:

    ```
    :DistantLaunch ssh://example.com distant.args="--port 8080"
    ```

## 5. Open a file on your remote machine

Opening a file is as simple as using a single command like below:

```
:DistantOpen /path/to/file.txt
```

This will open `/path/to/file.txt` by reading the remote file into a buffer in
your local neovim instance. From then on, and changes made will be written back
to the remote file.
