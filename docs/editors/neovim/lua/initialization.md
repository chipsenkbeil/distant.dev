The plugin is lazily-loaded, meaning that it is not fully loaded until some
method or field is accessed for the first time. This is done to avoid cyclical
dependencies as well as reduce the initial startup time of neovim when
leveraging distant.

Beyond lazily loading, the plugin also needs to be properly initialized, which
involves standing up autocommands and vim commands alongside preparing to use a
manager for connections. To configure the plugin, you need to call the setup
command:

```lua
plugin:setup()
```

Normally you would do this as part of your neovim configuration. There is no
harm in calling this method more than once, but only the first invocation will
actually perform all initialization procedures.

You can check for the plugin being initialized (calling `setup`) by invoking
the `is_initialized` function:

```lua
assert(plugin:is_initialized(), 'Distant plugin not initialized')
```

Checkout the [setup documentation](../../setup) for more information about
configuring the plugin.
