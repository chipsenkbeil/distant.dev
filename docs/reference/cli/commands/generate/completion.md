Generates a completion file for you for a specific shell.

### bash

```bash
distant generate completion bash -o ~/.bash_completion.d/distant.sh
```

### elvish

```elvish
distant generate completion elvish -o ~/.elvish/completions/distant.elv
```

### fish

```fish
distant generate completion fish -o ~/.config/fish/completions/distant.fish
```

### powershell

```pwsh
distant generate completion powershell -o $env:USERPROFILE\Documents\WindowsPowerShell\Modules\Distant\distant.ps1
```

### zsh

```zsh
distant generate completion zsh -o ~/.zsh/completions/_distant
```

{{ run("distant generate completion --help", admonition="info") }}
