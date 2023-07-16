The distant CLI offers a robust API in the form of JSON requests and responses
that are sent over stdin and stdout. When programmatically interacting with
distant, this API can be a great way to maintain a singular connection to the
server whether *distant*, *ssh*, or a future offering.

Today, there are two primary message formats that a client wishing to use the
JSON API must support:

* [Authentication][authentication] - when a server (or manager) needs to
  validate the client's access. This can occur when [launching][launch] or
  [connecting][connect] to a server, but is not limited to occurring in those
  situations. Authentication messages can technically be received at any time,
  such as when a server has expired access for a client and the client needs to
  reauthenticate.

* [Messages][messages] - the core API communicating between a client and a
  server. Any action the server has available is offered here, and while most
  communication starts by a client sending a request to the server, the order
  of messages is not guaranteed and asynchronous messages can be sent to the
  client by the server at any time.

[authentication]: /reference/cli/json-api/authentication/
[messages]: /reference/cli/json-api/messages/
[launch]: /reference/cli/commands/launch/
[connect]: /reference/cli/commands/connect/
