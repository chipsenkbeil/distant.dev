---
title: distant-manager-listen
---

# NAME

distant-manager-listen - Listen for incoming requests as a manager

# SYNOPSIS

**distant-manager-listen** \[**\--access**\] \[**\--daemon**\]
\[**\--user**\] \[**\--unix-socket**\] \[**\--windows-pipe**\]
\[**-h**\|**\--help**\]

# DESCRIPTION

Listen for incoming requests as a manager

# OPTIONS

**\--access**=*ACCESS*

:   Type of access to apply to created unix socket or windows pipe\

\
*Possible values:*

> -   owner: Equates to \`0o600\` on Unix (read & write for owner)
>
> -   group: Equates to \`0o660\` on Unix (read & write for owner and
>     group)
>
> -   anyone: Equates to \`0o666\` on Unix (read & write for owner,
>     group, and other)

**\--daemon**=*DAEMON*

:   If specified, will fork the process to run as a standalone daemon

**\--user**=*USER*

:   If specified, will listen on a user-local unix socket or local
    windows named pipe

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)
