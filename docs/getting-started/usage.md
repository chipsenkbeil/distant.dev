With the `distant` CLI, everything is packaged into a
single binary. This means that any machine that has distant installed is
capable of connecting to other machines as a client as well as listening for
remote connections to itself.

*[CLI]: Command-line Interface

## Starting a manager

If your goal is to connect to a remote machine, you first need to start a
*distant manager*, which will maintain all of the connections between you and
the remote machines. The fastest way to do this is by installing the manager as
a service on your local machine:

```sh
# Install the manager as a user-level service.
# If not available, remove the --user flag.
distant manager service install --user
```

Once installed, you can start the service manually like below:

```sh
# Start the manager as a user-level service.
# If not available, remove the --user flag.
distant manager service start --user
```

## Connecting to a remote machine

With a manager running, you can now connect to a remote machine. There are two
ways to do this:

1. **Launch:** this will connect to the remote machine, start up a distant
   server to listen for connections, and then connect to the distant server.
2. **Connect:** this will connect to a distant server or some compatible
   server such as SSH.

### Launching

{{ asciinema("/assets/videos/launching-distant.cast") }}

This starts a distant server remotely and connects to it. The process by which
we first connect to the remote machine is defined in the URI.

```sh
distant launch ssh://example.com
```

In the above example, this requests that the manager connects to an SSH server
located at *example.com*. Once established, a distant server is started on the
remote machine. Our manager then connects to the newly-started server over TCP
and disconnects from the SSH server. Once successful, an id tied to the
connection will be printed and client requests will be sent to the new distant
server.

!!! note

    This does NOT use an SSH server to perform actions like reading a file or
    running a process. This only uses SSH to log into the remote machine and
    start a distant server. Once that is finished, SSH is no longer used.

    To use an SSH server without the need for a distant binary on the remote
    machine, see the [connecting](#connecting) section.

### Connecting

{{ asciinema("/assets/videos/connecting-distant.cast") }}

This connects to an already-running server. This server could be `distant`,
`SSH`, or any other server where we have a distant-compatible client.

```sh
distant connect ssh://example.com
```

In the above example, this requests that the manager connects to an SSH server
located at *example.com*. Once successful, an id tied to the connection will be
printed and client requests will be translated to be run on SSH. Since this is
ssh, the default port of *22* is used if none is specified.

In contrast, if you wanted to connect to a distant server running on the same
machine, you can run `distant connect distant://example.com:8080` where you
specify the port of the distant server. Since there is no default port for
distant, you must specify the port here.

## Listening for connections

{{ asciinema("/assets/videos/distant-server-listen-foreground.cast") }}

Normally, you do not need to start a distant server manually. The act of
[launching](#launching) described above will start the server for you;
however, there may be times where it is desirable to start the server yourself.

```sh
distant server listen
```

The above starts a server that listens in the foreground. To fork the process
(or detach on Windows), you can supply the `--daemon` flag.

Notice the distinct URI printed out by the server when listening. This is
normally captured during launch over ssh, and represents the protocol used
(distant), the port the server is bound to (60969), and an encoded key used for
authentication purposes.
