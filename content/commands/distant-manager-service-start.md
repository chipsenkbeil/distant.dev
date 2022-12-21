---
title: distant-manager-service-start
---

# NAME

distant-manager-service-start - Start the manager as a service

# SYNOPSIS

**distant-manager-service-start** \[**\--kind**\] \[**\--user**\]
\[**-h**\|**\--help**\]

# DESCRIPTION

Start the manager as a service

# OPTIONS

**\--kind**=*KIND*

:   Type of service manager used to run this service, defaulting to
    platform native\

\
*Possible values:*

> -   launchd: Use launchd to manage the service
>
> -   openrc: Use OpenRC to manage the service
>
> -   rcd: Use rc.d to manage the service
>
> -   sc: Use Windows service controller to manage the service
>
> -   systemd: Use systemd to manage the service

**\--user**=*USER*

:   If specified, starts as a user-level service

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)
