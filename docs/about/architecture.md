## Connection models

When it comes to distant, there are three components:

* **Client:** used to submit requests to edit files, run programs, and more
  from your local machine to a remote machine running a server.
* **Server:** used to process requests on a remote machine where the server is
  running. For example, the server may get a request to write a file to disk or
  spawn a new language server.
* **Manager:** used to manage connections to multiple servers to reduce how
  many TCP connections are maintained between your local machine and one or
  more remote machines.

In the most straightforward form, the distant client on your local machine will
connect directly to the distant server on a remote machine. This mirrors
similar tooling like ssh.

<!-- 
  TODO: Add custom class to image so that the wrapping paragraph will center
        the image via `text-align:center`, the paragraph will be at width:100%,
        and the image tag will have some variable width going no larger than
        the image size, but depending on screen size will be some percentage
        like 50%, but if the screen is too small will be width 100%.

        Maybe width:80%, max-width:800px, min-width:250px
-->
![Single Direct Connection][Single Direct Connection]

Following this model, multiple connections to a server would result in multiple
TCP connections. This is the traditional client/server model.

![Multiple Direct Connection][Multiple Direct Connection]

The distant cli provides a manager, used by default, to facilitate and
coordinate connections with clients. On Unix systems, the manager listens on a
[Unix Domain Socket](https://en.wikipedia.org/wiki/Unix_domain_socket) whereas
on Windows the manager listens using a [Named
Pipe](https://learn.microsoft.com/en-us/windows/win32/ipc/named-pipes).

![Manager w/ Unix Domain Socket][Manager w/ Unix Domain Socket]

## Establishing connections

When a client first connects to a server, a TCP connection is established;
however, that is not the end of the connection setup with distant! There are
three primary steps that distant takes to fully configure a connection:

1. **Derive:** a *codec* used by the client & server to encode messages to send
   to each other. This includes any encryption to ensure privacy and prevent
   tampering of your data as well as compress the byte stream to reduce the
   burden on your bandwidth.

2. **Authenticate:** where the client will prove its identity with the server.
   This can vary depending on what methods the server supports, but by default
   the server will have a unique, random passphrase whenever it is run that the
   client will need to provide.

3. **Replay:** any data that was dropped or missed between the client and
   server. This happens whenever the client **re-establishes** a connection
   with the server, and results in a more reliable connect to the user (you)
   where any network glitches will be repaired by distant.

![Establish a Connection][Establish a Connection]

## Deriving a codec

Before any authentication is performed or user messages are sent, distant
ensures that the connection between the client and server is secure. To do
this, the client and server agree upon the encryption and compression to use
for the established connection.

1. **Provide options:** where the server will send the client all available
   encryption and compression options. For example, if the server supports
   [ChaCha20-Poly1305](https://en.wikipedia.org/wiki/ChaCha20-Poly1305), it
   will communicate that as an option for the client. By default, distant
   supports [XChaCha20-Poly1305](https://en.wikipedia.org/wiki/ChaCha20-Poly1305#XChaCha20-Poly1305_%E2%80%93_extended_nonce_variant)
   and compression like [gzip](https://en.wikipedia.org/wiki/Gzip).

2. **Select choices:** where the client will send the server the encryption and
   compression it will use for the connection. The server will then reciprocate
   by using the same encryption and compression.

3. **Derive shared key:** where the client and server will derive a shared,
   secret key for use with encryption. A random, public key and salt will be
   generated on the client and server. The public key and salt will be sent
   across, and then a mutual shared key will be derived. The shared key is NOT
   sent across the network. Today, this is done using NIST P-256 elliptic curve
   Diffie Hellman
   ([ECDH](https://en.wikipedia.org/wiki/Elliptic-curve_Diffie%E2%80%93Hellman))
   key exchange and a pseudorandom key (PRK) derived using
   [HKDF](https://en.wikipedia.org/wiki/HKDF) via an
   [HMAC](https://en.wikipedia.org/wiki/HMAC)-[SHA256](https://en.wikipedia.org/wiki/SHA-2)
   hash function.

![Derive codec][Derive codec]

## Authenticating

Once a secure connection is established, the server needs to ensure that the
client has authority to submit requests that will be processed on the remote
machine. Today, this is handled by validating a static passphrase/key, but in
the future this will support additional authentication methods such as
machine-local passphrases, public key authentication, and more.

1. **Provide options:** where the server will send the client all available
   methods for authentication. Today, this is *static_key*, but in the future
   could be methods like *passphrase*, *public_key*, *sms*, or even combination
   requirements like *passphrase,sms* for 2FA.

2. **Select choices:** where the client will send the server the methods it
   will attempt to use for authentication. For example, *public_key* and
   *passphrase,sms* would indicate that the client will authenticate using
   either method.

3. **Authenticate using method:** where the server will attempt to verify the
   client's authority using one of the available methods. It will begin by
   telling the client which method is being used. From there, the server will
   issue a series of challenges (e.g. what is the passphrase?) where the client
   will submit answers, a series of verification requests (e.g. is this host
   okay?) where the client will submit confirmations, and info/error messages.

   If authentication fails for a method, the next available and agreed upon
   method will be used. If this is the last available method, the server will
   sever the connection.

4. **Report success:** where the server will send the client a confirmation
   that authentication has succeeded. This lets the client know that no more
   authentication methods will be started and no additional challenges,
   verification requests, information, or errors will be sent.

![Authenticate with server][Authenticate with server]

## Re-establishing connection

When establishing a connection, there are two paths that can be taken: new
connection and previous connection. For both paths, the client and server will
derive a shared [one-time password
(OTP)](https://en.wikipedia.org/wiki/One-time_password) that is used when
re-establishing a connection to avoid needing to provide full
re-authentication.

![Establish New Connection][Establish New Connection]

With an existing connection, the process is a bit different. When first
connecting, after deriving the codec, the client will tell the server that it
is an existing connection with a specific id and OTP.

If the server is aware that a connection with the specified id exists *and*
that connection had the matching password associated for re-authentication,
then the server views the client as reconnecting and will agree to replay any
dropped frames. If neither of the requirements holds true, then the server will
sever the connection.

Once a connection has been re-authenticated using the OTP, a new OTP is derived
by the client and server to protect against resending the same password from a
compromised client/server.

The replay logic follows this process:

1. Both the client and server keep track of how many frames (packets) they have
   sent and received.

2. On reconnect, both client and server will send the other their sent and
   received frame counts as well as the total frames saved in memory that can
   be resent.

3. Both client and server will proceed to send any missing frames that the
   other side would not have processed due to the mismatched counts.

4. Both client and server will wait to receive N missing frames up to the
   available count from the other side.

![Re-establish connection][Re-establish connection]

[Single Direct Connection]:      /assets/images/architecture/single-direct-connection.png
[Multiple Direct Connection]:    /assets/images/architecture/multiple-direct-connection.png
[Manager w/ Unix Domain Socket]: /assets/images/architecture/manager-uds.png
[Establish a Connection]:        /assets/images/architecture/establish-a-connection.png
[Derive codec]:                  /assets/images/architecture/derive-codec.png
[Authenticate with server]:      /assets/images/architecture/authenticate-with-server.png
[Establish New Connection]:      /assets/images/architecture/establish-new-connection.png
[Re-establish connection]:       /assets/images/architecture/reestablish-connection.png
