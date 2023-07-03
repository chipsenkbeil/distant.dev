## Unix

### Typical Installation

Run this command from a **non-admin** POSIX shell to install distant with the
default version and host. distant will be installed to
`$HOME/.local/bin/distant`.

```sh
# Need to include -L to follow redirects as this returns 301
curl -L https://sh.distant.dev | sh

# Can also use wget to the same result
wget https://sh.distant.dev | sh
```

### Advanced Installation

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

#### For Root

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

#### Silent Installation

You can run with `-q` or `--quiet` to suppress all output. Check the exit code
via `$?` for the result.

```sh
# Omit outputs
./install.sh -q [other args]

# Print result
echo $?
```

## Windows

### Typical Installation

Run this command from a **non-admin** PowerShell to install distant with the
default version and host. distant will be installed to 
`%LocalAppData%\distant\bin\distant.exe`, which normally is a path like
`C:\Users\<YOUR USERNAME>\AppData\Local\distant\bin\distant.exe`.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm sh.distant.dev | iex
```

### Advanced Installation

If you want to have an advanced installation, you can download the installer
and manually execute it with parameters.

```powershell
irm sh.distant.dev -outfile 'install.ps1'
```

To see all configurable parameters of the installer.

```powershell
.\install.ps1 -?
```

For example, you could install distant to a custom directory, specify a
different version of distant to install, and bypass system proxy during
installation.

```powershell
.\install.ps1 -InstallDir 'D:\Applications\Distant\bin' -DistantVersion '0.20.0-alpha.10' -NoProxy
```

Or you can use the legacy method to configure custom directory by setting Environment Variables. (**Not Recommended**)

```powershell
$env:DISTANT_INSTALL_DIR='D:\Applications\Distant\bin'
$env:DISTANT_VERSION='0.20.0-alpha.10'
irm sh.distant.dev | iex
```

#### For Admin

Installation under the administrator console has been disabled by default for
security considerations. If you know what you are doing and want to install
distant as administrator, then download the installer and manually execute it
with the `-RunAsAdmin` parameter in an elevated console. Here is the example:

```powershell
irm sh.distant.dev -outfile 'install.ps1'
.\install.ps1 -RunAsAdmin [-OtherParameters ...]
# I don't care about other parameters and want a one-line command
iex "& {$(irm sh.distant.dev)} -RunAsAdmin"
```

#### Silent Installation

You can redirect all outputs to Out-Null or a log file to silence the
installer. And you can use `$LASTEXITCODE` to check the installation result, it
will be `0` when the installation success.

```powershell
# Omit outputs
.\install.ps1 [-Parameters ...] | Out-Null
# Or collect logs
.\install.ps1 [-Parameters ...] > install.log
# Get result
$LASTEXITCODE
```

## Manually download

With each release, binaries are built for a variety of platforms and made
available under the [releases section of Github](https://github.com/chipsenkbeil/distant/releases/).

Navigate to the releases section and download the appropriate binary for your
operating system and CPU architecture.

## From source

To build distant from source, you will need to have
[Git](https://git-scm.com/), [Rust](https://www.rust-lang.org/), and
[Cargo](https://github.com/rust-lang/cargo) installed.

1. Clone the repository via `git clone https://github.com/chipsenkbeil/distant.git`
2. From the root of the repository, build via `cargo build --release`
3. Copy the output binary from `target/release/distant` (or
   `target/release/distant.exe` on Windows)
