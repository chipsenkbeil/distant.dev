---
title: distant-server-listen
---

# NAME

distant-server-listen - Listen for incoming requests as a server

# SYNOPSIS

**distant-server-listen** \[**\--host**\] \[**\--port**\]
\[**-6**\|**\--use-ipv6**\] \[**\--shutdown**\] \[**\--current-dir**\]
\[**\--daemon**\] \[**\--key-from-stdin**\] \[**-h**\|**\--help**\]

# DESCRIPTION

Listen for incoming requests as a server

# OPTIONS

**\--host**=*ssh\|any\|IP*

:   Control the IP address that the distant binds to

There are three options here:

1\. \`ssh\`: the server will reply from the IP address that the SSH
connection came from (as found in the SSH_CONNECTION environment
variable). This is useful for multihomed servers.

2\. \`any\`: the server will reply on the default interface and will not
bind to a particular IP address. This can be useful if the connection is
made through ssh or another tool that makes the SSH connection appear to
come from localhost.

3\. \`IP\`: the server will attempt to bind to the specified IP address.

**\--port**=*PORT\[:PORT2\]*

:   Set the port(s) that the server will attempt to bind to

This can be in the form of PORT1 or PORT1:PORTN to provide a range of
ports. With \`\--port 0\`, the server will let the operating system pick
an available TCP port.

Please note that this option does not affect the server-side port used
by SSH

**-6**, **\--use-ipv6**=*USE_IPV6*

:   If specified, will bind to the ipv6 interface if host is \"any\"
    instead of ipv4

**\--shutdown**=*SHUTDOWN*

:   Logic to apply to server when determining when to shutdown
    automatically

1\. \"never\" means the server will never automatically shut down 2.
\"after=\<N\>\" means the server will shut down after N seconds 3.
\"lonely=\<N\>\" means the server will shut down after N seconds with no
connections

Default is to never shut down

**\--current-dir**=*CURRENT_DIR*

:   Changes the current working directory (cwd) to the specified
    directory

**\--daemon**=*DAEMON*

:   If specified, will fork the process to run as a standalone daemon

**\--key-from-stdin**=*KEY_FROM_STDIN*

:   If specified, the server will not generate a key but instead listen
    on stdin for the next 32 bytes that it will use as the key instead.
    Receiving less than 32 bytes before stdin is closed is considered an
    error and any bytes after the first 32 are not used for the key

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)
