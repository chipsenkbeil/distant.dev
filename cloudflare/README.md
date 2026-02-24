# Cloudflare

Contains code and other files that we upload to Cloudflare where
https://distant.dev is hosted.

## worker.js

This is our cloud worker, denoted as distant-installer, that is served via
https://sh.distant.dev and determines based on either a `family` query
parameter or user agent whether to our unix install script or windows install
script that located in our `site/static` folder.
