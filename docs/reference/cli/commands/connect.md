Connects to a remote machine through some method. Today, distant supports two
options to connect:

1. `distant` - connecting to a distant server such as below with TCP port 8080.

      ```sh
      distant connect distant://example.com:8080
      ```

2. `ssh` - connecting to an ssh server such as below on the default port 22.

      ```sh
      distant connect ssh://example.com
      ```

{{ run("distant connect --help", admonition="info") }}
