### Service

Install distant as a service on your local machine, which will leverage the
operating system's service manager to keep distant running, start distant when
your machine first boots, etc.

```sh
distant manager service install
```
   
The above will attempt to detect your operating system's service manager and
install the appropriate files to run the manager automatically.

If you are running this as a **non-root** user, then you may want to include
the `--user` flag. If the service manager supports user-level services, this
will install distant as a user-level service.

```sh
distant manager service install --user
```

Once installed, you will then start the service by running `distant manager
service start` or `distant manager service start --user`.

### Daemon

Run the distant manager as a background daemon. This will spawn the distant
manager and fork the process on Unix or detach the existing process on Windows.

```sh
distant manager listen --daemon
```

### Foreground

Run the distant manager as a foreground process. This will spawn the distant
manager and have it listen for requests. You can use this when you want to
manager the process entirely yourself.

```sh
distant manager listen
```
