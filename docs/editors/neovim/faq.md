## Why would I use this plugin over neovim 0.9's remote TUI?

The primary difference to consider is that the neovim remote TUI functionality
operates on keystrokes and mouse input while distant does networking through
actions:

* With keystrokes and mouse input, everything you type such as navigating
  through a file, highlighting text, yanking text, or changing a word gets
  communicated to the remote neovim instance. This means that network latency
  can have a major impact on your editing experience causing stuttering or
  other noticeable delays.

* In contrast with actions, distant only sends network traffic for operations
  like writing and reading a file or executing a program. This means that your
  typing experience is **not** impacted by network latency. Distant only sends
  requests when you do something that needs to interact remotely.

In addition to reducing the impact of network latency, distant also offers some
additional features which - at the time of neovim 0.9 - are additional
advantages over neovim's TUI:

* **Security**: distant provides authentication and encryption using a modern
  AEAD algorithm, [ChaCha20-Poly1305][chacha20-poly1305] (specifically
  XChaCha20-Poly1305).

* **Programability**: distant and distant.nvim provide a well-defined API to
  leverage the full suite of functionality including file IO, searching,
  watching, and process execution.

* **Persistence**: distant supports persistent connections over TCP that will
  reconnect when the network is dropped, enabling more stable and consistent
  interactions with the remote machine.

## How does this plugin differ from using neovim with sshfs?

There are a couple of primary differences that come to mind:

1. **Filesystem**: [sshfs][sshfs] is built using [FUSE][fuse], meaning that you
   need support for it as a userland filesystem. [distant.nvim][distant.nvim]
   requires no special filesystem as the file contents are only reflected in
   buffers. Anything you read goes into a buffer and anything you write gets
   transmitted across the network directly through the distant library.

2. **Program locations**: [distant][distant] supports running programs on the
   remote machine, colocated with your files. Language servers would run on the
   remote machine, for instance. When using [sshfs][sshfs] to mount the remote
   file system on your local machine, you would then run programs locally and
   point them to the mounted files.

### Resources

With [distant][distant], you are leveraging the resources of a remote machine.
This can be advantageous if you want to perform CPU or GPU intensive operations
without heavily impacting your local machine. With [sshfs][sshfs], you are
leveraging the resources of a local machine for programs that you run.
Depending on what you're doing, this can be much more expensive.

### Network latency

If a program needs to access the filesystem frequently, this would transmit a
lot of requests over the network, especially if working over a large set of
files. With [distant][distant], all of the filesystem operations would happen
directly on the remote machine and only the program's output would be
transmitted over the network.

### Strengths & weaknesses

There are other technical differences, but the distinctions above are - at the
moment - the differences that stand out. In some cases, using [sshfs][sshfs]
might be preferred, but for my use personally and at work this is the preferred
method. :smile:

If you want to think of what this more closely relates to, then take a look at
[VS Code Remote Development][vscode_remote] or the formerly-active [Nuclide
project][nuclide].

[chacha20-poly1305]: https://en.wikipedia.org/wiki/ChaCha20-Poly1305
[distant]: https://github.com/chipsenkbeil/distant
[distant.nvim]: https://github.com/chipsenkbeil/distant.nvim
[fuse]: https://en.wikipedia.org/wiki/Filesystem_in_Userspace
[nuclide]: https://nuclide.io/
[sshfs]: https://en.wikipedia.org/wiki/SSHFS
[vscode_remote]: https://code.visualstudio.com/docs/remote/remote-overview
