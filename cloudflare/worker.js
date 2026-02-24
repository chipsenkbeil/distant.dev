import uap from './ua-parser.min.js'

const UNIX_SCRIPT_NAME = "distant-installer.sh";
const WINDOWS_SCRIPT_NAME = "distant-installer.ps1";

const STATIC_URL          = "https://distant.dev/static";
const UNIX_SCRIPT_URL     = STATIC_URL + "/" + UNIX_SCRIPT_NAME;
const WINDOWS_SCRIPT_URL  = STATIC_URL + "/" + WINDOWS_SCRIPT_NAME;

export default {
  async fetch(request) {
    // "unix" or "windows"
    let family;

    const { searchParams } = new URL(request.url)

    // Check if we have a query parameter in the form of ?family=...
    const param_family = searchParams.get('family');
    if (typeof param_family === "string" && param_family.length > 0) {
      family = param_family;
      console.log(`Query parameter specifies family as ${family}`);
    }

    // Try to determine whether we are on Windows or Unix from the user agent
    if (!family) {
      const user_agent_header = request.headers.get("User-Agent") || "";
      if (user_agent_header != "") {
        console.log(`Parsing user agent header: ${user_agent_header}`);
        const ua = uap(user_agent_header);
        console.log('Parse results', ua);

        let os_name = ua.os.name;
        if (typeof os_name === "string") {
          os_name = os_name.toLowerCase().trim();
          console.log(`Checking if ${os_name} is windows`);
          if (os_name.startsWith("windows")) {
            family = "windows";
          } else {
            family = "unix";
          }
          console.log(`Set family to ${family}`);
        }
      }
    }

    // Default to downloading Unix family script
    if (!family) {
      family = "unix";
      console.log(`Defaulting to ${family}`);
    }

    // Grab and send back the appropriate script
    let script, script_url;
    switch (family) {
      case "unix":
        script = UNIX_SCRIPT_NAME;
        script_url = UNIX_SCRIPT_URL;
        break;
      case "windows":
        script = WINDOWS_SCRIPT_NAME;
        script_url = WINDOWS_SCRIPT_URL;
        break;
      default:
        return new Response(`Invalid script family: ${family}. Must be "unix" or "windows".`, {
          status: 400,
        })
    };

    console.log(`Fetching ${script_url}`);
    const res = await fetch(script_url, {
      method: "GET",
      redirect: "follow",
    });

    if (!res.ok) {
      if (res.status === 404) {
        return new Response(`Script missing for ${family}!`, {status: res.status});
      }

      return res;
    }

    const data = await res.blob();
    const contentDisposition = "attachment; filename=" + script;
    return new Response(data, {
      status: 200,
      headers: { 
        "Content-Type": "application/octet-stream", 
        "Content-Disposition": contentDisposition,
      }
    })
  },
};
