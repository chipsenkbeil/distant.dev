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

[distant]: https://github.com/chipsenkbeil/distant
[distant.nvim]: https://github.com/chipsenkbeil/distant.nvim
[fuse]: https://en.wikipedia.org/wiki/Filesystem_in_Userspace
[nuclide]: https://nuclide.io/
[sshfs]: https://en.wikipedia.org/wiki/SSHFS
[vscode_remote]: https://code.visualstudio.com/docs/remote/remote-overview
