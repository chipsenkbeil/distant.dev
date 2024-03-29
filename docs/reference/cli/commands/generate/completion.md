Generates a completion file for you for a specific shell.

```sh
distant generate completion bash
```

### Flags

* `--output <FILE>`: indicates that completion file should be saved to a
  file instead of printed to stdout.

### Examples

#### bash

```bash
distant generate completion bash --output ~/.bash_completion.d/distant.sh
```

#### elvish

```elvish
distant generate completion elvish --output ~/.elvish/completions/distant.elv
```

#### fish

```fish
distant generate completion fish --output ~/.config/fish/completions/distant.fish
```

#### powershell

```pwsh
distant generate completion powershell --output $env:USERPROFILE\Documents\WindowsPowerShell\Modules\Distant\distant.ps1
```

#### zsh

```zsh
distant generate completion zsh --output ~/.zsh/completions/_distant
```

{{ run("distant generate completion --help", admonition="info") }}
