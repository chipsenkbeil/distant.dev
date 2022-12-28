+++
title = "Examples"
description = "Examples"
weight = 4
+++

## Starting the manager

In order to facilitate communication between a client and server, you first
need to start the manager. This can be done in one of two ways:

1. Leverage the `service` functionality to spawn the manager using one of the
   following supported service management platforms:
  - [`sc.exe`](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754599(v=ws.11)) for use with [Window Service](https://en.wikipedia.org/wiki/Windows_service) (Windows)
  - [Launchd](https://en.wikipedia.org/wiki/Launchd) (MacOS)
  - [systemd](https://en.wikipedia.org/wiki/Systemd) (Linux)
  - [OpenRC](https://en.wikipedia.org/wiki/OpenRC) (Linux)
  - [rc.d](https://en.wikipedia.org/wiki/Init#Research_Unix-style/BSD-style) (FreeBSD)
2. Run the manager manually by using the `listen` subcommand

### Service management

```bash
# If you want to install the manager as a service, you can use the service
# interface available directly from the CLI
#
# By default, this will install a system-level service, which means that you
# will need elevated permissions to both install AND communicate with the
# manager
distant manager service install

# If you want to maintain a user-level manager service, you can include the
# --user flag. Note that this is only supported on MacOS (via launchd) and
# Linux (via systemd)
distant manager service install --user

# ........

# Once you have installed the service, you will normally need to start it
# manually or restart your machine to trigger startup on boot
distant manager service start # --user if you are working with user-level
```

### Manual start

```bash
# If you choose to run the manager without a service management platform, you
# can either run the manager in the foreground or provide --daemon to spawn and
# detach the manager

# Run in the foreground
distant manager listen

# Detach the manager where it will not terminate even if the parent exits
distant manager listen --daemon
```

## Interacting with a remote machine

Once you have a manager listening for client requests, you can begin
interacting with the manager, spawn and/or connect to servers, and interact
with remote machines.

```bash
# Connect to my.example.com on port 22 via SSH and start a distant server
distant client launch ssh://my.example.com

# After the connection is established, you can perform different operations
# on the remote machine via `distant client action {command} [args]`
distant client action copy path/to/file new/path/to/file
distant client action spawn -- echo 'Hello, this is from the other side'

# Opening a shell to the remote machine is trivial
distant client shell

# If you have more than one connection open, you can switch between active
# connections by using the `select` subcommand
distant client select '<ID>'

# For programmatic use, a REPL following the JSON API is available
distant client repl --format json
```
