# Issue Tracker: https://github.com/chipsenkbeil/distant.dev/issues
#
# NOTE: This is a modification of https://github.com/ScoopInstaller/Install/blob/656e17b67e8468edc5c5bd51bdad55642a03d9a4/install.ps1
#       that has been rewritten to support installing the distant.exe
#       binary on Windows platforms. The installation script retains the
#       same unlicense as denoted below.
#
# Unlicense License:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

<#
.SYNOPSIS
    Distant installer.
.DESCRIPTION
    The installer of Distant. For details please check the website.
.PARAMETER DistantHost
    Specifies Distant host (arch/platform) to install. This is normally a triple/quad.
    If not specified, will detect and use current system (e.g. x86_64-pc-windows-msvc).
.PARAMETER DistantVersion
    Specifies Distant version to install.
    If not specified, Distant will use the latest full release (not pre-release).
.PARAMETER InstallDir
    Specifies path where distant will be installed.
    If not specified, Distant will be installed to '$env:LocalAppData\distant\bin'.
.PARAMETER OnConflict
    Specifies how to handle the situation where distant is already installed.
    If not specified, will ask whether to continue. Accepts "Ask", "Fail", "Overwrite".
.PARAMETER NoProxy
    Bypass system proxy during the installation.
.PARAMETER Proxy
    Specifies proxy to use during the installation.
.PARAMETER ProxyCredential
    Specifies credential for the given proxy.
.PARAMETER ProxyUseDefaultCredentials
    Use the credentials of the current user for the proxy server that is specified by the -Proxy parameter.
.PARAMETER RunAsAdmin
    Force to run the installer as administrator.
.LINK
    https://distant.dev
.LINK
    https://github.com/chipsenkbeil/distant
#>
param(
    [String] $DistantHost,
    [String] $DistantVersion,
    [String] $InstallDir,
    [String] $OnConflict,
    [Switch] $NoProxy,
    [Uri] $Proxy,
    [System.Management.Automation.PSCredential] $ProxyCredential,
    [Switch] $ProxyUseDefaultCredentials,
    [Switch] $RunAsAdmin
)

# Disable StrictMode in this script
Set-StrictMode -Off

function Get-Github-Url {
    param(
        [Parameter(Mandatory = $True, Position = 0)]
        [String] $BaseUrl,
        [Parameter(Mandatory = $True, Position = 1)]
        [String] $Version
    )

    # Remove leading/trailing whitespace from the version string
    $Version = $Version.Trim()

    # Check if the version is "latest"
    if ($Version -eq "latest") {
        return "$BaseUrl/releases/latest/download"
    }

    # Check if the version starts with a number
    if ($Version -match "^\d") {
        return "$BaseUrl/releases/download/v$Version"
    }

    # Default case: version is not "latest" and doesn't start with a number
    return "$BaseUrl/releases/download/$Version"
}

function Get-Host-Triple {
    # Get the architecture of the current system
    $architecture = $env:PROCESSOR_ARCHITECTURE.ToLower()

    # Set the default host triple based on the architecture and MSVC toolchain
    if ($architecture -eq "amd64") {
        $hostTriple = "x86_64-pc-windows-msvc"
    }
    elseif ($architecture -eq "arm64") {
        $hostTriple = "aarch64-pc-windows-msvc"
    }
    else {
        Deny-Install "Unsupported architecture detected. Only amd64 and arm64 are allowed."
    }

    return $hostTriple
}

function Write-InstallInfo {
    param(
        [Parameter(Mandatory = $True, Position = 0)]
        [String] $String,
        [Parameter(Mandatory = $False, Position = 1)]
        [System.ConsoleColor] $ForegroundColor = $host.UI.RawUI.ForegroundColor
    )

    $backup = $host.UI.RawUI.ForegroundColor

    if ($ForegroundColor -ne $host.UI.RawUI.ForegroundColor) {
        $host.UI.RawUI.ForegroundColor = $ForegroundColor
    }

    Write-Output "$String"

    $host.UI.RawUI.ForegroundColor = $backup
}

function Deny-Install {
    param(
        [String] $message,
        [Int] $errorCode = 1
    )

    Write-InstallInfo -String $message -ForegroundColor DarkRed
    Write-InstallInfo "Abort."

    # Don't abort if invoked with iex that would close the PS session
    if ($IS_EXECUTED_FROM_IEX) {
        break
    } else {
        exit $errorCode
    }
}

function Test-ValidateParameter {
    if ($null -eq $Proxy -and ($null -ne $ProxyCredential -or $ProxyUseDefaultCredentials)) {
        Deny-Install "Provide a valid proxy URI for the -Proxy parameter when using the -ProxyCredential or -ProxyUseDefaultCredentials."
    }

    if ($ProxyUseDefaultCredentials -and $null -ne $ProxyCredential) {
        Deny-Install "ProxyUseDefaultCredentials is conflict with ProxyCredential. Don't use the -ProxyCredential and -ProxyUseDefaultCredentials together."
    }
}

function Test-IsAdministrator {
    return ([Security.Principal.WindowsPrincipal]`
            [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -and $env:USERNAME -ne 'WDAGUtilityAccount'
}

function Test-Prerequisite {
    # Distant requires PowerShell 5 at least
    if (($PSVersionTable.PSVersion.Major) -lt 5) {
        Deny-Install "PowerShell 5 or later is required to run installer. Go to https://microsoft.com/powershell to get the latest version of PowerShell."
    }

    # distant installer requires TLS 1.2 SecurityProtocol, which exists in .NET Framework 4.5+
    # TODO: Do we need this for the installer? Leftover from modifying scoop installer!
    if ([System.Enum]::GetNames([System.Net.SecurityProtocolType]) -notcontains 'Tls12') {
        Deny-Install "distant installer requires .NET Framework 4.5+ to work. Go to https://microsoft.com/net/download to get the latest version of .NET Framework."
    }

    # Detect if RunAsAdministrator, there is no need to run as administrator when installing distant.
    if (!$RunAsAdmin -and (Test-IsAdministrator)) {
        Deny-Install "Running the installer as administrator is disabled by default. Please download the script and manually execute it with the -RunAsAdmin parameter in an elevated console."
    }

    # Show notification to change execution policy
    $allowedExecutionPolicy = @("Unrestricted", "RemoteSigned", "ByPass")
    if ((Get-ExecutionPolicy).ToString() -notin $allowedExecutionPolicy) {
        Deny-Install "PowerShell requires an execution policy in [$($allowedExecutionPolicy -join ", ")] to run distant. For example, to set the execution policy to 'RemoteSigned' please run 'Set-ExecutionPolicy RemoteSigned -Scope CurrentUser'."
    }

    # Test if distant is installed, by checking if distant command exists.
    if (Test-CommandAvailable("distant")) {
        switch ($ON_CONFLICT.Trim().ToLower()) {
            # If overwrite, will delete the version of distant and replace it
            "overwrite" {
                $Path = (Get-Command -Name distant).Path
                Write-InstallInfo "Deleting existing binary at $Path"
                Remove-Item -Force $Path
            }

            # If fail, will deny the installation immediately
            "fail" {
                Deny-Install "Distant is already installed."
            }

            # Anything else falls back to asking
            default {
                $Cursor = [System.Console]::CursorTop
                Do {
                    [System.Console]::CursorTop = $Cursor
                    Clear-Host
                    $Answer = Read-Host -Prompt "Distant is already installed. Overwrite it? (y/n)"
                }
                Until ($Answer -eq 'y' -or $Answer -eq 'n')

                if ($Answer -eq 'y') {
                    $Path = (Get-Command -Name distant).Path
                    Write-InstallInfo "Deleting existing binary at $Path"
                    Remove-Item -Force $Path
                } else {
                    Deny-Install "Will exit installation as not overwriting distant."
                }
            }
        }
    }
}

function Optimize-SecurityProtocol {
    # .NET Framework 4.7+ has a default security protocol called 'SystemDefault',
    # which allows the operating system to choose the best protocol to use.
    # If SecurityProtocolType contains 'SystemDefault' (means .NET4.7+ detected)
    # and the value of SecurityProtocol is 'SystemDefault', just do nothing on SecurityProtocol,
    # 'SystemDefault' will use TLS 1.2 if the webrequest requires.
    $isNewerNetFramework = ([System.Enum]::GetNames([System.Net.SecurityProtocolType]) -contains 'SystemDefault')
    $isSystemDefault = ([System.Net.ServicePointManager]::SecurityProtocol.Equals([System.Net.SecurityProtocolType]::SystemDefault))

    # If not, change it to support TLS 1.2
    if (!($isNewerNetFramework -and $isSystemDefault)) {
        # Set to TLS 1.2 (3072), then TLS 1.1 (768), and TLS 1.0 (192). Ssl3 has been superseded,
        # https://docs.microsoft.com/en-us/dotnet/api/system.net.securityprotocoltype?view=netframework-4.5
        [System.Net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor 192
        Write-Verbose "SecurityProtocol has been updated to support TLS 1.2"
    }
}

function Get-Downloader {
    $downloadSession = New-Object System.Net.WebClient

    # Set proxy to null if NoProxy is specificed
    if ($NoProxy) {
        $downloadSession.Proxy = $null
    } elseif ($Proxy) {
        # Prepend protocol if not provided
        if (!$Proxy.IsAbsoluteUri) {
            $Proxy = New-Object System.Uri("http://" + $Proxy.OriginalString)
        }

        $Proxy = New-Object System.Net.WebProxy($Proxy)

        if ($null -ne $ProxyCredential) {
            $Proxy.Credentials = $ProxyCredential.GetNetworkCredential()
        } elseif ($ProxyUseDefaultCredentials) {
            $Proxy.UseDefaultCredentials = $true
        }

        $downloadSession.Proxy = $Proxy
    }

    return $downloadSession
}

function Get-Env {
    param(
        [String] $name,
        [Switch] $global
    )

    $RegisterKey = if ($global) {
        Get-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
    } else {
        Get-Item -Path 'HKCU:'
    }

    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment')
    $RegistryValueOption = [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames
    $EnvRegisterKey.GetValue($name, $null, $RegistryValueOption)
}

function Publish-Env {
    if (-not ("Win32.NativeMethods" -as [Type])) {
        Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern IntPtr SendMessageTimeout(
    IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
    uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
    }

    $HWND_BROADCAST = [IntPtr] 0xffff
    $WM_SETTINGCHANGE = 0x1a
    $result = [UIntPtr]::Zero

    [Win32.Nativemethods]::SendMessageTimeout($HWND_BROADCAST,
        $WM_SETTINGCHANGE,
        [UIntPtr]::Zero,
        "Environment",
        2,
        5000,
        [ref] $result
    ) | Out-Null
}

function Write-Env {
    param(
        [String] $name,
        [String] $val,
        [Switch] $global
    )

    $RegisterKey = if ($global) {
        Get-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'
    } else {
        Get-Item -Path 'HKCU:'
    }

    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment', $true)
    if ($val -eq $null) {
        $EnvRegisterKey.DeleteValue($name)
    } else {
        $RegistryValueKind = if ($val.Contains('%')) {
            [Microsoft.Win32.RegistryValueKind]::ExpandString
        } elseif ($EnvRegisterKey.GetValue($name)) {
            $EnvRegisterKey.GetValueKind($name)
        } else {
            [Microsoft.Win32.RegistryValueKind]::String
        }
        $EnvRegisterKey.SetValue($name, $val, $RegistryValueKind)
    }
    Publish-Env
}

function Add-BinDirToPath {
    # Get $env:PATH of current user
    $userEnvPath = Get-Env 'PATH'

    if ($userEnvPath -notmatch [Regex]::Escape($INSTALL_DIR)) {
        $h = (Get-PSProvider 'FileSystem').Home
        if (!$h.EndsWith('\')) {
            $h += '\'
        }

        if (!($h -eq '\')) {
            $friendlyPath = "$INSTALL_DIR" -Replace ([Regex]::Escape($h)), "~\"
            Write-InstallInfo "Adding $friendlyPath to your path."
        } else {
            Write-InstallInfo "Adding $INSTALL_DIR to your path."
        }

        # For future sessions
        Write-Env 'PATH' "$INSTALL_DIR;$userEnvPath"
        # For current session
        $env:PATH = "$INSTALL_DIR;$env:PATH"
    }
}

function Test-CommandAvailable {
    param (
        [Parameter(Mandatory = $True, Position = 0)]
        [String] $Command
    )
    return [Boolean](Get-Command $Command -ErrorAction SilentlyContinue)
}

function Write-DebugInfo {
    param($BoundArgs)

    Write-Verbose "-------- PSBoundParameters --------"
    $BoundArgs.GetEnumerator() | ForEach-Object { Write-Verbose $_ }
    Write-Verbose "-------- Environment Variables --------"
    Write-Verbose "`$env:LocalAppData: $env:LocalAppData"
    Write-Verbose "`$env:DISTANT_HOST: $env:DISTANT_HOST"
    Write-Verbose "`$env:DISTANT_VERSION: $env:DISTANT_VERSION"
    Write-Verbose "`$env:DISTANT_INSTALL_DIR: $env:DISTANT_INSTALL_DIR"
    Write-Verbose "`$env:DISTANT_ON_CONFLICT: $env:DISTANT_ON_CONFLICT"
    Write-Verbose "-------- Selected Variables --------"
    Write-Verbose "DISTANT_HOST: $DISTANT_HOST"
    Write-Verbose "DISTANT_VERSION: $DISTANT_VERSION"
    Write-Verbose "INSTALL_DIR: $INSTALL_DIR"
    Write-Verbose "ON_CONFLICT: $ON_CONFLICT"
}

function Install-Distant {
    Write-InstallInfo "Initializing..."
    # Validate install parameters
    Test-ValidateParameter
    # Check prerequisites
    Test-Prerequisite
    # Enable TLS 1.2
    Optimize-SecurityProtocol

    # Build our url pointing to the exe to download
    $downloadUrl = "$(Get-Github-Url $DISTANT_GITHUB_REPO $DISTANT_VERSION)/distant-$DISTANT_HOST.exe"

    # Ensure our bin directory exists
    if (-not (Test-Path -Path $INSTALL_DIR)) {
        New-Item -ItemType Directory -Path $INSTALL_DIR | Out-Null
    }

    # Specify the full path where the binary will be located
    $downloadPath = Join-Path -Path $INSTALL_DIR -ChildPath "distant.exe"

    # Initialize the downloader to get our binary
    $downloader = Get-Downloader

    # Download our binary into the install directory
    Write-InstallInfo "Downloading $downloadUrl to $downloadPath"
    $downloader.DownloadFile($downloadUrl, $downloadPath)
    $downloader.Dispose()

    # Ensure distant binary is in the PATH
    Add-BinDirToPath

    Write-InstallInfo "Distant was installed successfully!" -ForegroundColor DarkGreen
    Write-InstallInfo "Type 'distant help' for instructions."
}

# Prepare variables
$IS_EXECUTED_FROM_IEX = ($null -eq $MyInvocation.MyCommand.Path)

# Remote repo where downloads are available
$DISTANT_GITHUB_REPO = "https://github.com/chipsenkbeil/distant"

# Input variables
$DISTANT_HOST       = $DistantHost, $env:DISTANT_HOST, "$(Get-Host-Triple)" | Where-Object { -not [String]::IsNullOrEmpty($_) } | Select-Object -First 1
$DISTANT_VERSION    = $DistantVersion, $env:DISTANT_VERSION, "latest" | Where-Object { -not [String]::IsNullOrEmpty($_) } | Select-Object -First 1
$INSTALL_DIR        = $InstallDir, $env:DISTANT_INSTALL_DIR, "$env:LocalAppData\distant\bin" | Where-Object { -not [String]::IsNullOrEmpty($_) } | Select-Object -First 1
$ON_CONFLICT        = $OnConflict, $env:DISTANT_ON_CONFLICT, "Ask" | Where-Object { -not [String]::IsNullOrEmpty($_) } | Select-Object -First 1

# Quit if anything goes wrong
$oldErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

# Logging debug info
Write-DebugInfo $PSBoundParameters
# Bootstrap function
Install-Distant

# Reset $ErrorActionPreference to original value
$ErrorActionPreference = $oldErrorActionPreference
