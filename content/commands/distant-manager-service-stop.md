---
title: distant-manager-service-stop
---

# NAME

distant-manager-service-stop - Stop the manager as a service

# SYNOPSIS

**distant-manager-service-stop** \[**\--kind**\] \[**\--user**\]
\[**-h**\|**\--help**\]

# DESCRIPTION

Stop the manager as a service

# OPTIONS

**\--kind**=*KIND*

:   \
    *Possible values:*

    -   launchd: Use launchd to manage the service

    -   openrc: Use OpenRC to manage the service

    -   rcd: Use rc.d to manage the service

    -   sc: Use Windows service controller to manage the service

    -   systemd: Use systemd to manage the service

**\--user**=*USER*

:   If specified, stops a user-level service

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)
