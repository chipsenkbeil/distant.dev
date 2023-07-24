Settings are normally defined as part of setting up the plugin during the setup
stage:

```lua
plugin:setup({
  buffer = {
    watch = {
      enabled = true
    }
  }
})
```

You can also update settings post-setup by directly modifying the `settings`
field on the plugin itself. Keep in mind that some settings may only be read
once, meaning that modifying them later may not always result in the change
being applied (e.g. keymaps).

```lua
plugin.settings.buffer.watch.enabled = true
```
