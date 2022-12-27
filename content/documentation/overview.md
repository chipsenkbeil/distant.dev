+++
title = "Overview"
description = "Overview"
weight = 1
+++

Distant is a collection of tooling and libraries to support working with remote
machines. In its simplest form, there is a client and server where you run the
client on your local machine and the server on a remote machine. A TCP
connection is established between the client and server, and from there you are
able to edit files and run programs on the remote machine.

* Reading, writing, and querying a remote filesystem
  * File IO
  * Directory IO
  * Search
* Executing and managing processes on the remote machine
  * Run programs, writing to their stdin, and reading from their stdout/stderr
  * Spawn shells using a PTY

The distant cli is monolithic, meaning that all features are
contained in a single binary. This means that you do not need to install
a different program to run the client, server, or manager. You also do not need
to worry about having different shared libraries (.so) or DLLs (.dll)
available on your system to run distant.

