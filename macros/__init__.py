import uuid

def value_str(value):
    s = str(value)
    if isinstance(value, bool):
        s = s.lower()
    return s

def define_env(env):
    """
    This is the hook for defining variables, macros and filters
    """

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

        # Create script tag that will perform cast
        html += "<script>"
        html += "document.addEventListener('DOMContentLoaded', function() {"
        html += "AsciinemaPlayer.create('" + file + "', document.getElementById('" + div_id + "'), {"
        for key, value in opts.items():
            html += '"' + key + '": ' + value_str(value) + ','
        html += "});"
        html += "});"
        html += "</script>"
    
        return html
