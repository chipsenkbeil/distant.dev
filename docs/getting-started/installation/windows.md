## Typical Installation

Run this command from a **non-admin** PowerShell to install distant with the
default version and host. distant will be installed to 
`%LocalAppData%\distant\bin\distant.exe`, which normally is a path like
`C:\Users\<YOUR USERNAME>\AppData\Local\distant\bin\distant.exe`.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm sh.distant.dev | iex
```

## Advanced Installation

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

Or you can provide arguments inline such as this example.

```powershell
iex "& {$(irm sh.distant.dev)} -InstallDir 'D:\Applications\Distant\bin' -DistantVersion '0.20.0-alpha.10' -NoProxy"
```

Or you can use the legacy method to configure custom directory by setting Environment Variables. (**Not Recommended**)

```powershell
$env:DISTANT_INSTALL_DIR='D:\Applications\Distant\bin'
$env:DISTANT_VERSION='0.20.0-alpha.10'
irm sh.distant.dev | iex
```

### For Admin

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

### Silent Installation

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
