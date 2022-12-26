+++
title = "About"
sort_by = "weight"
is_search_index = false
page_template = "page.html"
+++

Distant is a collection of tooling and libraries to support working with remote
machines. Specifically, it is geared towards providing the following:

* Reading, writing, and querying a remote filesystem
  * File IO
  * Directory IO
  * Search
* Executing and managing processes on the remote machine
  * Run programs, writing to their stdin, and reading from their stdout/stderr
  * Spawn shells using a PTY

The CLI is a single, monolithic binary that provides a client, server, manager,
and other utilities. The purpose is to reduce complexity - needing multiple
different binaries - as well as increase the likelihood that you as a user have
everything you need to work with remote machines successfully.

# Architecture
