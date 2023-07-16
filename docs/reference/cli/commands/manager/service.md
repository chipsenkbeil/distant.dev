Interact with a manager being run by a service management platform.

```sh
distant manager service ...
```

### Commands

* `install`: will install a basic configuration file to run distant using the
  native (or explicitly defined) service manager. For some platforms, this will
  also start the service.

* `start`: will start the distant service using the native (or explicitly
  defined) service manager.

* `stop`: will stop the distant service using the native (or explicitly
  defined) service manager.

* `uninstall`: will uninstall the distant service using the native (or
  explicitly defined) service manager.

### Flags

* `--kind <KIND>`: use a specific service manager denoted by the `kind`. By
  default, the native system manager detected by distant will be used such as
  `sc.exe` for Windows or `launchd` on MacOS.

    * **launchd**: use launchd to manage the service.
    * **openrc**:  use OpenRC to manage the service.
    * **rcd**:     use rc.d to manage the service.
    * **sc**:      use Windows service controller to manage the service.
    * **systemd**: use systemd to manage the service.

* `--user`: indicates that the service is for the current user and not a
  globally-available service. Not all service managers support user-level
  services, but this can be preferred for those that do such as `launchd` and
  `systemd`.
    
{{ run("distant manager service --help", admonition="info") }}
