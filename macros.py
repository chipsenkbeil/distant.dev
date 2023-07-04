import subprocess
import uuid

def value_str(value):
    s = str(value)
    if isinstance(value, bool):
        s = s.lower()
    return s

def define_env(env):
    # Define feature icons
    env.variables["f_full"]    = ':white_check_mark:{ title="Full support" }'
    env.variables["f_partial"] = ':warning:{ title="Partial support" }'
    env.variables["f_none"]    = ':x:{ title="No support" }'

    @env.macro
    def asciinema(file, **kwargs):
        html = ""
        opts = {
            "autoPlay": True,
            "controls": False,
            "loop": True,
        }

        # Overwrite defaults with kwargs
        for key, value in kwargs.items():
            opts[key] = value

        # Create an empty div that we will use for the player
        div_id = "asciinema-" + str(uuid.uuid4())
        div_style = "z-index: 1; position: relative;"
        html += '<div id="' + div_id + '" style="' + div_style + '"></div>'

        # Define JS representing creating the player
        create_player_js = ""
        create_player_js += "AsciinemaPlayer.create('" + file + "', document.getElementById('" + div_id + "'), {"
        for key, value in opts.items():
            create_player_js += '"' + key + '": ' + value_str(value) + ','
        create_player_js += "});"

        # Create script tag that will perform cast by either registering for the DOM to
        # load or firing immediately if already loaded
        html += "<script>"
        html += "if (document.readyState === 'loading') {"
        html += "document.addEventListener('DOMContentLoaded', function() {"
        html += create_player_js
        html += "});"
        html += "} else {"
        html += create_player_js
        html += "}"
        html += "</script>"
    
        return html

    @env.macro
    def run(cmd, into_admonition=False):
        # Start by capturing everything
        stdout = subprocess.PIPE
        stderr = subprocess.STDOUT

        result = subprocess.run(
            cmd,
            check=False,
            text=True,
            shell=True,
            stdout=stdout,
            stderr=stderr,
        )
        output = result.stdout.strip()

        if into_admonition:
            admonition = '??? info "' + cmd + '"\n'
            admonition += "\n"
            admonition += "    ```\n"
            for line in output.splitlines():
                admonition += "    " + line + "\n"
            admonition += "    ```"
            return admonition

        return output
