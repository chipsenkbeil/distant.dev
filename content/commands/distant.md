---
title: distant
---

# NAME

distant - Operate on a remote computer through file and process
manipulation

# SYNOPSIS

**distant** \[**\--log-level**\] \[**\--log-file**\]
\[**-c**\|**\--config**\] \[**-h**\|**\--help**\]
\[**-V**\|**\--version**\] \<*subcommands*\>

# DESCRIPTION

Operate on a remote computer through file and process manipulation

# OPTIONS

**\--log-level**=*LOG_LEVEL*

:   Log level to use throughout the application\

\
\[*possible values: *off, error, warn, info, debug, trace\]

**\--log-file**=*LOG_FILE*

:   Path to file to use for logging

**-c**, **\--config**=*CONFIG_PATH*

:   Configuration file to load instead of the default paths

**-h**, **\--help**

:   Print help information

**-V**, **\--version**

:   Print version information

# SUBCOMMANDS

distant-client(1)

:   Perform client commands

distant-manager(1)

:   Perform manager commands

distant-server(1)

:   Perform server commands

distant-generate(1)

:   Perform generation commands

distant-help(1)

:   Print this message or the help of the given subcommand(s)

# VERSION

v0.20.0-alpha.3

# AUTHORS

Chip Senkbeil \<chip\@senkbeil.org\>
