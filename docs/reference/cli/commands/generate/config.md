Generates a default `config.toml` file for you.

```sh
distant generate config --output $HOME/.config/distant/config.toml
```

### Flags

* `--output <FILE>`: indicates that config file should be saved to a
  file instead of printed to stdout.

### Examples

#### Saving to the default location on MacOS

```sh
distant generate config --output "$HOME/Library/Application Support/distant/config.toml"
```

#### Saving to the default location on Unix/Linux

```sh
distant generate config --output "$HOME/.config/distant/config.toml"
```

#### Saving to the default location on Windows

```powershell
distant generate config --output "$env:USERPROFILE\AppData\Roaming\distant\config\config.toml"
```

{{ run("distant generate config", admonition="example", title="Default config.toml", lang="toml") }}

{{ run("distant generate config --help", admonition="info") }}
