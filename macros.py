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
    def issue(num):
        base_url = "https://github.com/chipsenkbeil/distant/issues"
        return "<a href=\"" + base_url + "/" + str(num) + "\">#" + str(num) + "</a>"

    @env.macro
    def run(cmd, admonition=None, title=None, lang=None, collapsible=True, expanded=False):
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

        if admonition is not None:
            # ADMONITION START LINE #
            if collapsible:
                admonition = "???" + ("+" if expanded else "") + " " + admonition
                if expanded:
                    admonition += "+"
            else:
                admonition = "!!! " + admonition
            admonition += ' "'
            if isinstance(title, str):
                admonition += title
            else:
                admonition += cmd

            admonition += '"\n'

            # BLANK LINE #
            admonition += "\n"

            # << START CODE BLOCK >> #
            admonition += "    ```"

            if isinstance(lang, str):
                admonition += lang

            admonition += "\n"

            for line in output.splitlines():
                admonition += "    " + line + "\n"

            admonition += "    ```"
            # << END CODE BLOCK >> #

            return admonition

        return output
