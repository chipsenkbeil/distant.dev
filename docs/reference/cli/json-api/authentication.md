When a server (or manager) needs to validate the client's access. This can
occur when [launching][launch] or [connecting][connect] to a server, but is not
limited to occurring in those situations.

Authentication messages can technically be received at any time, such as when a
server has expired access for a client and the client needs to re-authenticate.

!!! note

    All authentication methods will contain a `type` field denoting their
    purpose.

## Initialization

<div class="grid" markdown>

When authentication first begins, a JSON message is sent from the server to the
client containing a `type` of *auth_initialization* and an additional `methods`
field representing array of strings describing the possible ways the server can
authenticate the client.

```json title="Request"
{
    "type": "auth_initialization",
    "methods": ["...", "..."]
}
```

</div>

#### Types of methods

* *none*: indicates that the server does not need authentication. This is
  normally found with the manager, which itself is a server that listens for
  actions to perform. Normal practice is to respond with just *none* as the
  method choice.
* *static_key*: indicates that the server can authenticate using a singular,
  32-byte string key. Typically, this key lasts the lifetime of the server and
  does not change.

#### Response

<div class="grid" markdown>

In response to initialization, a JSON message should be sent comprised of a
`type` set to *auth_initialization_response* and an additional `methods` field
representing which of the presented authentication methods the client wants to
attempt.

```json title="Response"
{
    "type": "auth_initialization_response",
    "methods": ["...", "..."]
}
```

</div>

## Start Method

<div class="grid" markdown>

When authentication begins challenges for a specific method, a JSON message is
sent from the server to the client containing a `type` of *auth_start_method*
and an additional `method` field indicating which method is starting.

```json title="Request"
{
    "type": "auth_start_method",
    "method": "..."
}
```

</div>

!!! note

    There is no response for this request. It is purely informative.

## Challenge

<div class="grid" markdown>

The primary method of authentication, one or more challenges will be issued to
the client by the server. For each challenge, a JSON message is sent containing
a `type` of *auth_challenge* and two additional fields: `questions` and
`options`.

```json title="Request"
{
    "type": "auth_challenge",
    "questions": [
        {
            "label": "...", 
            "text": "...", 
            "options": { "...": "..." }
        }
    ],
    "options": { "...": "..." }
}
```

</div>

#### Explanation of fields

* `questions`: is an object comprised of a `label`, `text`, and `options`.

    * `label`: describes the challenge such as *key* when asking for a key for
      the *static_key* method. This can be used programmatically to determine
      what is being asked.

    * `text`: more robust, human-readable text associated with the challenge.
      This can typically be printed when a human is interacting with
      authentication to answer questions.

    * `options`: object comprised of additional options associated with the
      question.
      
          For ssh, this may include zero or more of specialized fields:
          
          * `echo`: if `"true"`, indicates the answer being typed should be
            printed out, otherwise it is sensitive and should be hidden.
          
          * `instructions`: additional text to print out related to the
            question.
          
          * `username`: name of a specific user tied to the question.

* `options`: object comprised of additional options associated with the
  challenge.

#### Response

<div class="grid" markdown>

In response to a challenge, a JSON message should be sent comprised of a
`type` set to *auth_challenge_response* and an additional `answers` field
comprised of an answer to each of the questions provided in the request. This
field should have the same number of entries as the `questions` field.

```json title="Response"
{
    "type": "auth_challenge_response",
    "answers": ["...", "..."]
}
```

</div>


## Verification

<div class="grid" markdown>

Alongside challenges, the server may also request the client verify certain
information before proceeding. In this situation, a JSON message is sent
containing a `type` of *auth_verification* and two additional fields: `kind`
and `text`. The text field serves as a human-readable explanation of the ask.

```json title="Request"
{
    "type": "auth_verification",
    "kind": "...",
    "text": "..."
}
```

</div>

#### Types of verification

* *host*: an ask to verify the host such as with SSH
* *unknown*: an unknown ask (happens when the client is unaware of the kind)

#### Response

<div class="grid" markdown>

In response to verification, a JSON message should be sent comprised of a
`type` set to *auth_verification_response* and an additional `valid` field
indicating to accept the request (`true`), or deny it (`false`).

```json title="Response"
{
    "type": "auth_verification_response",
    "valid": true
}
```

</div>

## Info

<div class="grid" markdown>

When additional information is available during authentication , a JSON message
is sent from the server to the client containing a `type` of *auth_info*
alongside a `text` field, which contains the additional information.

```json title="Request"
{
    "type": "auth_info",
    "text": "..."
}
```

</div>

!!! note

    There is no response for this request. It is purely informative.

## Error

<div class="grid" markdown>

When authentication encounters an error (typically failing a challenge), a JSON
message is sent from the server to the client containing a `type` of
*auth_error* alongside two additional fields: `kind` and `text`. The `text`
field is a description of the error.

```json title="Request"
{
    "type": "auth_error",
    "kind": "fatal|error",
    "text": "..."
}
```

</div>

#### Types of errors

The `kind` field can be one of two values:

* *error*: the error can be recovered and authentication will continue.
* *fatal*: the error cannot be recovered and the connection will be severed.

!!! note

    There is no response for this request. It is purely informative.

## Finished

<div class="grid" markdown>

When authentication has completed successfully, a JSON message is
sent from the server to the client containing a `type` of *auth_finished*.

```json title="Request"
{
    "type": "auth_finished"
}
```

</div>

!!! note

    There is no response for this request. It is purely informative.

[launch]: /reference/cli/commands/launch/
[connect]: /reference/cli/commands/connect/
