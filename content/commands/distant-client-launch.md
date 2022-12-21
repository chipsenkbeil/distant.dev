---
title: distant-client-launch
---

# NAME

distant-client-launch - Launches the server-portion of the binary on a
remote machine

# SYNOPSIS

**distant-client-launch** \[**\--cache**\] \[**\--distant**\]
\[**\--distant-bind-server**\] \[**\--distant-args**\]
\[**\--options**\] \[**\--unix-socket**\] \[**\--windows-pipe**\]
\[**-f**\|**\--format**\] \[**-h**\|**\--help**\] \<*DESTINATION*\>

# DESCRIPTION

Launches the server-portion of the binary on a remote machine

# OPTIONS

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**\--distant**=*distant*

:   Path to distant program on remote machine to execute via ssh; by
    default, this program needs to be available within PATH as specified
    when compiling ssh (not your login shell)

**\--distant-bind-server**=*ssh\|any\|IP*

:   Control the IP address that the server binds to.

The default is \`ssh, in which case the server will reply from the IP
address that the SSH connection came from (as found in the
SSH_CONNECTION environment variable). This is useful for multihomed
servers.

With \--bind-server=any, the server will reply on the default interface
and will not bind to a particular IP address. This can be useful if the
connection is made through sslh or another tool that makes the SSH
connection appear to come from localhost.

With \--bind-server=IP, the server will attempt to bind to the specified
IP address.

**\--distant-args**=*distant-args*

:   Additional arguments to provide to the server

**\--options**=*OPTIONS* \[default: \]

:   Additional options to provide, typically forwarded to the handler
    within the manager facilitating the launch of a distant server.
    Options are key-value pairs separated by comma.

E.g. \`key=\"value\",key2=\"value2\"\`

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**-f**, **\--format**=*FORMAT* \[default: shell\]

:   \
    *Possible values:*

    -   json: Sends and receives data in JSON format

    -   shell: Commands are traditional shell commands and output
        responses are inline with what is expected of a programs output
        in a shell

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\<*DESTINATION*\>

:   
