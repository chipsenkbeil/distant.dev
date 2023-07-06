#!/bin/sh
# shellcheck shell=dash

# It runs on Unix shells like {a,ba,da,k,z}sh. It uses the common `local`
# extension. Note: Most shells limit `local` to 1 var per line, contra bash.

if [ "$KSH_VERSION" = 'Version JM 93t+ 2010-03-05' ]; then
    # The version of ksh93 that ships with many illumos systems does not
    # support the "local" extension.  Print a message rather than fail in
    # subtle ways later on:
    echo 'distant-installer.sh does not work with this ksh93 version; please try bash!' >&2
    exit 1
fi


set -u

DISTANT_REPO="${DISTANT_REPO:-https://github.com/chipsenkbeil/distant}"

# Global flags to be configured
QUIET=
VERBOSE=
RUN_AS_ADMIN=

usage() {
    get_architecture || return 1
    local _arch="$RETVAL"

    cat <<EOF
distant-installer.sh 1.0.0
The installer for distant

USAGE:
    distant-installer.sh [OPTIONS]

OPTIONS:
    -q, --quiet
            Disable output entirely.
            If on-conflict is "ask", this will force it to "fail".

    -v, --verbose
            Print out additional information.

        --install-dir <dir>
            Specifies path where distant will be installed.
            If not specified, will be installed into $HOME/.local/bin.

        --on-conflict <action>
            Specifies the action to take if distant is already installed.
            If not specified, will ask whether or not to overwrite.
            Choices are "ask", "fail", and "overwrite".

        --distant-host <host>
            Choose a specific build of distant (arch/platform).
            If not provided, will use "$_arch".

        --distant-version <version>
            Choose a version of distant to install.
            If not provided, will use the latest stable release.

        --run-as-admin
            Force to run the installer as administrator.
            Normally, if the script is run as root, it will fail; however,
            enabling this option will allow the script to continue.

    -h, --help
            Print help information.
EOF
}

main() {
    local _script_name
    _script_name="$0"

    #
    # VERIFY SYSTEM HAS NEEDED TOOLS
    #

    # Ensure that we have curl or wget alongside other needed tools
    downloader --check
    need_cmd uname
    need_cmd chmod
    need_cmd mkdir

    #
    # POPULATE DEFAULTS
    #

    # Detect the architecture to use (triple representing platform)
    get_architecture || return 1
    local _arch="$RETVAL"
    assert_nz "$_arch" "arch"

    # If we are on windows, we need to add .exe to the end
    local _ext=""
    case "$_arch" in
        *windows*)
            _ext=".exe"
            ;;
    esac

    # Set default version to latest release
    # Support DISTANT_VERSION environment variable
    local _version
    _version="${DISTANT_VERSION:-latest}"

    # Directory where distant will be installed
    # Support DISTANT_INSTALL_DIR environment variable
    local _dir
    _dir="${DISTANT_INSTALL_DIR:-$HOME/.local/bin}"

    # Set default handling of a conflict
    # Support DISTANT_ON_CONFLICT environment variable
    local _on_conflict
    _on_conflict="${DISTANT_ON_CONFLICT:-ask}"

    #
    # READ CLI ARGUMENTS
    #

    while [ "$#" -gt 0 ]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -q|--quiet)
                QUIET=yes
                shift # past argument
                ;;
            -v|--verbose)
                VERBOSE=yes
                shift # past argument
                ;;
            --install-dir)
                _dir="$2"
                shift # past argument
                shift # past value
                ;;
            --on-conflict)
                _on_conflict="$2"
                shift # past argument
                shift # past value
                ;;
            --distant-host)
                _arch="$2"
                shift # past argument
                shift # past value
                ;;
            --distant-version)
                _version="$2"
                shift # past argument
                shift # past value
                ;;
            --run-as-admin)
                RUN_AS_ADMIN=yes
                shift # past argument
                ;;
            *)
                err "Unknown argument $1"
                ;;
        esac
    done

    # We will avoid prompting when quiet
    if [ ! "$_on_conflict" = "overwrite" ] && [ "$QUIET" = "yes" ]; then
        _on_conflict="fail"
    fi

    #
    # PRINT VERBOSE INFORMATION
    #

    say_verbose "-------- Environment Variables --------"
    say_verbose "DISTANT_HOST: ${DISTANT_HOST:-}"
    say_verbose "DISTANT_VERSION: ${DISTANT_VERSION:-}"
    say_verbose "DISTANT_INSTALL_DIR: ${DISTANT_INSTALL_DIR:-}"
    say_verbose "DISTANT_ON_CONFLICT: ${DISTANT_ON_CONFLICT:-}"
    say_verbose "-------- Selected Variables --------"
    say_verbose "QUIET: $QUIET"
    say_verbose "VERBOSE: $VERBOSE"
    say_verbose "DISTANT_HOST: $_arch"
    say_verbose "DISTANT_VERSION: $_version"
    say_verbose "INSTALL_DIR: $_dir"
    say_verbose "ON_CONFLICT: $_on_conflict"
    say_verbose ""

    #
    # PERFORM CHECKS
    #

    say "Initializing..."

    # If we are running as root and not explicitly told to support this,
    # then we want to fail with an error message
    if [ "$(id -u)" -eq 0 ] && [ ! "$RUN_AS_ADMIN" = "yes" ]; then
        err "Running the installer as root is disabled by default. If you really want to do this, rerun with --run-as-admin."
    fi

    # Check if the install directory exists, and create it if it does not
    if [ ! -d "$_dir" ]; then
        ensure mkdir -p "$_dir"
    fi

    # Check that we have permission to write files within the directory
    if [ ! -w "$_dir" ]; then
        err "Directory $_dir is not writable where distant would be installed!"
    fi

    # Set the full path to where distant will be installed
    local _file
    _file="${_dir}/distant${_ext}"

    # Check if the distant binary already exists, and handle accordingly
    if [ -e "$_file" ]; then
        case "$_on_conflict" in
            overwrite)
                say "Removing existing binary at $_file" 1>&2
                rm "$_file"
                ;;
            fail)
                err "distant is already installed"
                ;;
            *)
                local _answer
                while [ ! "${_answer:-}" = "y" ] && [ ! "${_answer:-}" = "n" ]; do
                    _answer=$(prompt "Distant is already installed. Overwrite it? (y/n)" "")
                done

                if [ "$_answer" = "y" ]; then
                    say "Removing existing binary at $_file" 1>&2
                    rm "$_file"
                else
                    err "distant is already installed"
                fi
                ;;
        esac
    fi

    # Set the url we will use to download
    local _url
    _url="$(github_url "$DISTANT_REPO" "$_version")/distant-${_arch}${_ext}"

    #
    # PERFORM DOWNLOAD, PERMISSION SETTING, AND VERSION TEST
    #

    local _ansi_escapes_are_valid=false
    if [ -t 2 ]; then
        if [ "${TERM+set}" = 'set' ]; then
            case "$TERM" in
                xterm*|rxvt*|urxvt*|linux*|vt*)
                    _ansi_escapes_are_valid=true
                ;;
            esac
        fi
    fi

    # Download and install the binary
    say "Downloading $_url to $_file" 1>&2
    ensure downloader "$_url" "$_file" "$_arch"
    ensure chmod u+x "$_file"
    if [ ! -x "$_file" ]; then
        err "Cannot execute $_file (unexpectedly failed to set permissions)."
    fi

    if [ $_ansi_escapes_are_valid ] && [ ! "$QUIET" = "yes" ] ; then
        # NOTE: Need to do it this way for ansi escapes to work
        # \33[ is escape; 0m is default fg color; 32m is dark green fg color
        printf "\33[32mDistant was installed successfully!\33[0m\n" 1>&2
    else
        say "Distant was installed successfully!" 1>&2
    fi
    say "Make sure to add \"$_dir\" to your PATH!" 1>&2
    say "Type '$_file help' for instructions." 1>&2

    exit 0
}

check_proc() {
    # Check for /proc by looking for the /proc/self/exe link
    # This is only run on Linux
    if ! test -L /proc/self/exe ; then
        err "fatal: Unable to find /proc/self/exe.  Is /proc mounted?  Installation cannot proceed without /proc."
    fi
}

get_bitness() {
    need_cmd head
    # Architecture detection without dependencies beyond coreutils.
    # ELF files start out "\x7fELF", and the following byte is
    #   0x01 for 32-bit and
    #   0x02 for 64-bit.
    # The printf builtin on some shells like dash only supports octal
    # escape sequences, so we use those.
    local _current_exe_head
    _current_exe_head=$(head -c 5 /proc/self/exe )
    if [ "$_current_exe_head" = "$(printf '\177ELF\001')" ]; then
        echo 32
    elif [ "$_current_exe_head" = "$(printf '\177ELF\002')" ]; then
        echo 64
    else
        err "unknown platform bitness"
    fi
}

is_host_amd64_elf() {
    need_cmd head
    need_cmd tail
    # ELF e_machine detection without dependencies beyond coreutils.
    # Two-byte field at offset 0x12 indicates the CPU,
    # but we're interested in it being 0x3E to indicate amd64, or not that.
    local _current_exe_machine
    _current_exe_machine=$(head -c 19 /proc/self/exe | tail -c 1)
    [ "$_current_exe_machine" = "$(printf '\076')" ]
}

get_endianness() {
    local cputype=$1
    local suffix_eb=$2
    local suffix_el=$3

    # detect endianness without od/hexdump, like get_bitness() does.
    need_cmd head
    need_cmd tail

    local _current_exe_endianness
    _current_exe_endianness="$(head -c 6 /proc/self/exe | tail -c 1)"
    if [ "$_current_exe_endianness" = "$(printf '\001')" ]; then
        echo "${cputype}${suffix_el}"
    elif [ "$_current_exe_endianness" = "$(printf '\002')" ]; then
        echo "${cputype}${suffix_eb}"
    else
        err "unknown platform endianness"
    fi
}

#
# Detects architecture and returns it by setting `RETVAL` to the
# `cputype-ostype` where:
#
# * `cputype`:  TODO
# * `ostype`: TODO
#
# Collectively, this should result in a valid triple like:
#
# * x86_64-apple-darwin
# * x86_64-unknown-linux-gnu (in the case of Linux, we have gnu/musl as 4th)
get_architecture() {
    local _ostype _cputype _bitness _arch _clibtype
    _ostype="$(uname -s)"
    _cputype="$(uname -m)"
    _clibtype="gnu"

    if [ "$_ostype" = Linux ]; then
        if [ "$(uname -o)" = Android ]; then
            _ostype=Android
        fi
        if ldd --version 2>&1 | grep -q 'musl'; then
            _clibtype="musl"
        fi
    fi

    if [ "$_ostype" = Darwin ] && [ "$_cputype" = i386 ]; then
        # Darwin `uname -m` lies
        if sysctl hw.optional.x86_64 | grep -q ': 1'; then
            _cputype=x86_64
        fi
    fi

    if [ "$_ostype" = SunOS ]; then
        # Both Solaris and illumos presently announce as "SunOS" in "uname -s"
        # so use "uname -o" to disambiguate.  We use the full path to the
        # system uname in case the user has coreutils uname first in PATH,
        # which has historically sometimes printed the wrong value here.
        if [ "$(/usr/bin/uname -o)" = illumos ]; then
            _ostype=illumos
        fi

        # illumos systems have multi-arch userlands, and "uname -m" reports the
        # machine hardware name; e.g., "i86pc" on both 32- and 64-bit x86
        # systems.  Check for the native (widest) instruction set on the
        # running kernel:
        if [ "$_cputype" = i86pc ]; then
            _cputype="$(isainfo -n)"
        fi
    fi

    case "$_ostype" in

        Android)
            _ostype=linux-android
            ;;

        Linux)
            check_proc
            _ostype=unknown-linux-$_clibtype
            _bitness=$(get_bitness)
            ;;

        FreeBSD)
            _ostype=unknown-freebsd
            ;;

        NetBSD)
            _ostype=unknown-netbsd
            ;;

        DragonFly)
            _ostype=unknown-dragonfly
            ;;

        Darwin)
            _ostype=apple-darwin
            ;;

        illumos)
            _ostype=unknown-illumos
            ;;

        MINGW* | MSYS* | CYGWIN* | Windows_NT)
            _ostype=pc-windows-gnu
            ;;

        *)
            err "unrecognized OS type: $_ostype"
            ;;

    esac

    case "$_cputype" in

        i386 | i486 | i686 | i786 | x86)
            _cputype=i686
            ;;

        xscale | arm)
            _cputype=arm
            if [ "$_ostype" = "linux-android" ]; then
                _ostype=linux-androideabi
            fi
            ;;

        armv6l)
            _cputype=arm
            if [ "$_ostype" = "linux-android" ]; then
                _ostype=linux-androideabi
            else
                _ostype="${_ostype}eabihf"
            fi
            ;;

        armv7l | armv8l)
            _cputype=armv7
            if [ "$_ostype" = "linux-android" ]; then
                _ostype=linux-androideabi
            else
                _ostype="${_ostype}eabihf"
            fi
            ;;

        aarch64 | arm64)
            _cputype=aarch64
            ;;

        x86_64 | x86-64 | x64 | amd64)
            _cputype=x86_64
            ;;

        mips)
            _cputype=$(get_endianness mips '' el)
            ;;

        mips64)
            if [ "$_bitness" -eq 64 ]; then
                # only n64 ABI is supported for now
                _ostype="${_ostype}abi64"
                _cputype=$(get_endianness mips64 '' el)
            fi
            ;;

        ppc)
            _cputype=powerpc
            ;;

        ppc64)
            _cputype=powerpc64
            ;;

        ppc64le)
            _cputype=powerpc64le
            ;;

        s390x)
            _cputype=s390x
            ;;
        riscv64)
            _cputype=riscv64gc
            ;;
        loongarch64)
            _cputype=loongarch64
            ;;
        *)
            err "unknown CPU type: $_cputype"

    esac

    # Detect 64-bit linux with 32-bit userland (and fail)
    if [ "${_ostype}" = unknown-linux-gnu ] && [ "${_bitness}" -eq 32 ]; then
        err "32-bit userland is unsupported!"
    fi

    # Detect armv7 but without the CPU features Rust needs in that build,
    # and fall back to arm.
    # See https://github.com/rust-lang/rustup.rs/issues/587.
    if [ "$_ostype" = "unknown-linux-gnueabihf" ] && [ "$_cputype" = armv7 ]; then
        if ensure grep '^Features' /proc/cpuinfo | grep -q -v neon; then
            # At least one processor does not have NEON.
            _cputype=arm
        fi
    fi

    _arch="${_cputype}-${_ostype}"

    RETVAL="$_arch"
}

#
# Prompts for value, storing it into `RETVAL`.
#
prompt() {
    local _prompt
    local _value
    local _default_value

    _prompt="$1"
    _default_value="$2"

    if [ -z "$_default_value" ]; then
        printf "%s: " "$_prompt" >&2
    else
        printf "%s [%s]: " "$_prompt" "$_default_value" >&2
    fi

    if [ ! -t 0 ]; then
        read -r _value < /dev/tty
    else
        read -r _value
    fi

    if [ -z "$_value" ]; then
        _value="$_default_value"
    fi

    echo "$_value"
}

say() {
    if [ ! "$QUIET" = "yes" ]; then
        printf '%s\n' "$1"
    fi
}

say_verbose() {
    if [ "$VERBOSE" = "yes" ]; then
        say "$1"
    fi
}

err() {
    say "distant-installer.sh: $1" >&2
    exit 1
}

# Given `repo` and `version`, returns URL.
#
# Version can be a tag or `latest`.
github_url() {
    local _repo="$1"
    local _version="$2"

    # Latest has a different path than branches & tags
    if [ "$_version" = "latest" ]; then
        echo "$_repo/releases/latest/download"
    else
        case "$_version" in
            # Starts with a digit, implies semver, so stick v in front
            0*|1*|2*|3*|4*|5*|6*|7*|8*|9*)
                echo "$_repo/releases/download/v$_version"
                ;;
            # Otherwise, use version as-is
            *)
                echo "$_repo/releases/download/$_version"
                ;;
        esac
    fi
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

assert_nz() {
    if [ -z "$1" ]; then err "assert_nz $2"; fi
}

# Run a command that should never fail. If the command fails execution
# will immediately terminate with an error showing the failing
# command.
ensure() {
    if ! "$@"; then err "command failed: $*"; fi
}

# This is just for indicating that commands' results are being
# intentionally ignored. Usually, because it's being executed
# as part of error handling.
ignore() {
    "$@"
}

# This wraps curl or wget. Tries curl and then wget.
#
# Arguments are either:
#
# * --check (validates we have an available cmd)
# * "url", "file", "platform" where
#     * `url`: full URL to binary to download
#     * `file`: full local path to store binary
#     * `platform`: triple representing platform/architecture
#
# Returns true on success, otherwise false.
downloader() {
    local _dld
    local _ciphersuites
    local _err
    local _status
    local _retry
    if check_cmd curl; then
        _dld=curl
    elif check_cmd wget; then
        _dld=wget
    else
        _dld='curl or wget' # to be used in error message of need_cmd
    fi

    if [ "$1" = --check ]; then
        need_cmd "$_dld"
    elif [ "$_dld" = curl ]; then
        check_curl_for_retry_support
        _retry="$RETVAL"
        get_ciphersuites_for_curl
        _ciphersuites="$RETVAL"
        if [ -n "$_ciphersuites" ]; then
            _err=$(curl $_retry --proto '=https' --tlsv1.2 --ciphers "$_ciphersuites" --silent --show-error --fail --location "$1" --output "$2" 2>&1)
            _status=$?
        else
            echo "Warning: Not enforcing strong cipher suites for TLS, this is potentially less secure"
            if ! check_help_for "$3" curl --proto --tlsv1.2; then
                echo "Warning: Not enforcing TLS v1.2, this is potentially less secure"
                _err=$(curl $_retry --silent --show-error --fail --location "$1" --output "$2" 2>&1)
                _status=$?
            else
                _err=$(curl $_retry --proto '=https' --tlsv1.2 --silent --show-error --fail --location "$1" --output "$2" 2>&1)
                _status=$?
            fi
        fi
        if [ -n "$_err" ]; then
            echo "$_err" >&2
            if echo "$_err" | grep -q 404$; then
                err "binary for platform '$3' not found, this may be unsupported"
            fi
        fi
        return $_status
    elif [ "$_dld" = wget ]; then
        if [ "$(wget -V 2>&1|head -2|tail -1|cut -f1 -d" ")" = "BusyBox" ]; then
            echo "Warning: using the BusyBox version of wget.  Not enforcing strong cipher suites for TLS or TLS v1.2, this is potentially less secure"
            _err=$(wget "$1" -O "$2" 2>&1)
            _status=$?
        else
            get_ciphersuites_for_wget
            _ciphersuites="$RETVAL"
            if [ -n "$_ciphersuites" ]; then
                _err=$(wget --https-only --secure-protocol=TLSv1_2 --ciphers "$_ciphersuites" "$1" -O "$2" 2>&1)
                _status=$?
            else
                echo "Warning: Not enforcing strong cipher suites for TLS, this is potentially less secure"
                if ! check_help_for "$3" wget --https-only --secure-protocol; then
                    echo "Warning: Not enforcing TLS v1.2, this is potentially less secure"
                    _err=$(wget "$1" -O "$2" 2>&1)
                    _status=$?
                else
                    _err=$(wget --https-only --secure-protocol=TLSv1_2 "$1" -O "$2" 2>&1)
                    _status=$?
                fi
            fi
        fi
        if [ -n "$_err" ]; then
            echo "$_err" >&2
            if echo "$_err" | grep -q ' 404 Not Found$'; then
                err "binary for platform '$3' not found, this may be unsupported"
            fi
        fi
        return $_status
    else
        err "Unknown downloader"   # should not reach here
    fi
}

#
# Checks help information for a command to detect if it contains some argument(s).
#
# 1. `arch`: the architecture being used such as "x86_64-apple-darwin"
# 2. `cmd`: the command being used to download a file (curl, wget)
# 3+. `arg`: an argument that should be supported by the command (one or more)
#
# Returns true if help contains all arguments, otherwise false.
check_help_for() {
    local _arch
    local _cmd
    local _arg
    _arch="$1"
    shift
    _cmd="$1"
    shift

    local _category
    if "$_cmd" --help | grep -q 'For all options use the manual or "--help all".'; then
      _category="all"
    else
      _category=""
    fi

    case "$_arch" in

        *darwin*)
        if check_cmd sw_vers; then
            case $(sw_vers -productVersion) in
                10.*)
                    # If we're running on macOS, older than 10.13, then we always
                    # fail to find these options to force fallback
                    if [ "$(sw_vers -productVersion | cut -d. -f2)" -lt 13 ]; then
                        # Older than 10.13
                        echo "Warning: Detected macOS platform older than 10.13"
                        return 1
                    fi
                    ;;
                11.*)
                    # We assume Big Sur will be OK for now
                    ;;
                *)
                    # Unknown product version, warn and continue
                    echo "Warning: Detected unknown macOS major version: $(sw_vers -productVersion)"
                    echo "Warning TLS capabilities detection may fail"
                    ;;
            esac
        fi
        ;;

    esac

    for _arg in "$@"; do
        if ! "$_cmd" --help "$_category" | grep -q -- "$_arg"; then
            return 1
        fi
    done

    true # not strictly needed
}

# Check if curl supports the --retry flag, then pass it to the curl invocation.
check_curl_for_retry_support() {
    local _retry_supported=""
    # "unspecified" is for arch, allows for possibility old OS using macports, homebrew, etc.
    if check_help_for "notspecified" "curl" "--retry"; then
        _retry_supported="--retry 3"
        if check_help_for "notspecified" "curl" "--continue-at"; then
            # "-C -" tells curl to automatically find where to resume the download when retrying.
            _retry_supported="--retry 3 -C -"
        fi
    fi

    RETVAL="$_retry_supported"
}

# Return cipher suite string specified by user, otherwise return strong TLS 1.2-1.3 cipher suites
# if support by local tools is detected. Detection currently supports these curl backends:
# GnuTLS and OpenSSL (possibly also LibreSSL and BoringSSL). Return value can be empty.
get_ciphersuites_for_curl() {
    if [ -n "${DISTANT_INSTALLER_TLS_CIPHERSUITES-}" ]; then
        # user specified custom cipher suites, assume they know what they're doing
        RETVAL="$DISTANT_INSTALLER_TLS_CIPHERSUITES"
        return
    fi

    local _openssl_syntax="no"
    local _gnutls_syntax="no"
    local _backend_supported="yes"
    if curl -V | grep -q ' OpenSSL/'; then
        _openssl_syntax="yes"
    elif curl -V | grep -iq ' LibreSSL/'; then
        _openssl_syntax="yes"
    elif curl -V | grep -iq ' BoringSSL/'; then
        _openssl_syntax="yes"
    elif curl -V | grep -iq ' GnuTLS/'; then
        _gnutls_syntax="yes"
    else
        _backend_supported="no"
    fi

    local _args_supported="no"
    if [ "$_backend_supported" = "yes" ]; then
        # "unspecified" is for arch, allows for possibility old OS using macports, homebrew, etc.
        if check_help_for "notspecified" "curl" "--tlsv1.2" "--ciphers" "--proto"; then
            _args_supported="yes"
        fi
    fi

    local _cs=""
    if [ "$_args_supported" = "yes" ]; then
        if [ "$_openssl_syntax" = "yes" ]; then
            _cs=$(get_strong_ciphersuites_for "openssl")
        elif [ "$_gnutls_syntax" = "yes" ]; then
            _cs=$(get_strong_ciphersuites_for "gnutls")
        fi
    fi

    RETVAL="$_cs"
}

# Return cipher suite string specified by user, otherwise return strong TLS 1.2-1.3 cipher suites
# if support by local tools is detected. Detection currently supports these wget backends:
# GnuTLS and OpenSSL (possibly also LibreSSL and BoringSSL). Return value can be empty.
get_ciphersuites_for_wget() {
    if [ -n "${DISTANT_INSTALLER_TLS_CIPHERSUITES-}" ]; then
        # user specified custom cipher suites, assume they know what they're doing
        RETVAL="$DISTANT_INSTALLER_TLS_CIPHERSUITES"
        return
    fi

    local _cs=""
    if wget -V | grep -q '\-DHAVE_LIBSSL'; then
        # "unspecified" is for arch, allows for possibility old OS using macports, homebrew, etc.
        if check_help_for "notspecified" "wget" "TLSv1_2" "--ciphers" "--https-only" "--secure-protocol"; then
            _cs=$(get_strong_ciphersuites_for "openssl")
        fi
    elif wget -V | grep -q '\-DHAVE_LIBGNUTLS'; then
        # "unspecified" is for arch, allows for possibility old OS using macports, homebrew, etc.
        if check_help_for "notspecified" "wget" "TLSv1_2" "--ciphers" "--https-only" "--secure-protocol"; then
            _cs=$(get_strong_ciphersuites_for "gnutls")
        fi
    fi

    RETVAL="$_cs"
}

# Return strong TLS 1.2-1.3 cipher suites in OpenSSL or GnuTLS syntax. TLS 1.2
# excludes non-ECDHE and non-AEAD cipher suites. DHE is excluded due to bad
# DH params often found on servers (see RFC 7919). Sequence matches or is
# similar to Firefox 68 ESR with weak cipher suites disabled via about:config.
# $1 must be openssl or gnutls.
get_strong_ciphersuites_for() {
    if [ "$1" = "openssl" ]; then
        # OpenSSL is forgiving of unknown values, no problems with TLS 1.3 values on versions that don't support it yet.
        echo "TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384"
    elif [ "$1" = "gnutls" ]; then
        # GnuTLS isn't forgiving of unknown values, so this may require a GnuTLS version that supports TLS 1.3 even if wget doesn't.
        # Begin with SECURE128 (and higher) then remove/add to build cipher suites. Produces same 9 cipher suites as OpenSSL but in slightly different order.
        echo "SECURE128:-VERS-SSL3.0:-VERS-TLS1.0:-VERS-TLS1.1:-VERS-DTLS-ALL:-CIPHER-ALL:-MAC-ALL:-KX-ALL:+AEAD:+ECDHE-ECDSA:+ECDHE-RSA:+AES-128-GCM:+CHACHA20-POLY1305:+AES-256-GCM"
    fi
}

main "$@" || exit 1
