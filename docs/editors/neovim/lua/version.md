If you need access to the supported version of distant or the version of the
plugin itself, you can access this directly from the `version` field.

All versions follow [Semantic Versioning 2.0.0](https://semver.org/) and are
instances of the [version table](../core/version).

### CLI version

Today, the plugin exposes a minimum version requirement for the local distant
CLI used to communicate with servers and run/speak with the manager.

```lua
-- Minimum version of the CLI supported by the plugin
plugin.version.cli.min
```

### Plugin's version

The plugin itself has a version that is followed, typically aligning to both
the branch and (if applicable) tag:

```lua
-- Version of the plugin itself, which is normally a rough estimate such as 0.3
plugin.version.plugin
```
