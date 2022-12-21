---
title: distant-client-lsp
---

# NAME

distant-client-lsp - Specialized treatment of running a remote LSP
process

# SYNOPSIS

**distant-client-lsp** \[**\--cache**\] \[**\--connection**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**\--pty**\]
\[**-h**\|**\--help**\] \<*CMD*\>

# DESCRIPTION

Specialized treatment of running a remote LSP process

# OPTIONS

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**\--connection**=*CONNECTION*

:   Specify a connection being managed

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**\--pty**=*PTY*

:   If provided, will run LSP in a pty

**-h**, **\--help**

:   Print help information

\<*CMD*\>

:   
