## Typical Installation

Run this command from a **non-admin** POSIX shell to install distant with the
default version and host. distant will be installed to
`$HOME/.local/bin/distant`.

```sh
# Need to include -L to follow redirects as this returns 301
curl -L https://sh.distant.dev | sh

# Can also use wget to the same result
wget https://sh.distant.dev | sh
```

## Advanced Installation

If you want to have an advanced installation, you can download the installer
and manually execute it with parameters.

```sh
# Download script to install.sh
curl -L https://sh.distant.dev -o install.sh

# Make the installer executable, otherwise you need to run with
# `sh install.sh [args]`
chmod +x install.sh
```

To see all configurable parameters of the installer.

```sh
./install.sh --help
```

For example, you could install distant to a custom directory and specify a
different version of distant to install.

```sh
./install.sh --install-dir '/path/to/dir' --distant-version '0.20.0-alpha.10'
```

Or you can provide arguments inline via `sh -s -- [args]` such as this example.

```sh
curl -L https://sh.distant.dev | sh -s -- --install-dir '/path/to/dir' --distant-version '0.20.0-alpha.10'
```

Or you can use the legacy method to configure custom directory by setting
Environment Variables. (**Not Recommended**)

```sh
export DISTANT_INSTALL_DIR='/path/to/dir'
export DISTANT_VERSION='0.20.0-alpha.10'
curl -L https://sh.distant.dev | sh
```

### For Root

Installation under root has been disabled by default for security
considerations. If you know what you are doing and want to install distant as
root, then download the installer and manually execute it with the
`--run-as-admin` parameter. Here is the example:

```sh
# Download script and make it executable
curl -L https://sh.distant.dev -o install.sh
chmod +x ./install.sh

./install.sh --run-as-admin [other args]

# I don't care about other parameters and want a one-line command
curl -L https://sh.distant.dev | sh -s -- --run-as-admin
```

### Silent Installation

You can run with `-q` or `--quiet` to suppress all output. Check the exit code
via `$?` for the result.

```sh
# Omit outputs
./install.sh -q [other args]

# Print result
echo $?
```
