# A Paperless-ngx port for FreeBSD
The port will install [paperless-ngx](https://paperless-ngx.com) from a release on [FreeBSD](https://www.freebsd.org/).

# To-do
[ ] Install files to `/opt/paperless`
[ ] Use gunicorn instead of the development HTTP server
[ ] Use inotify instead of polling the consumption folder: [inotify_simple PR](https://github.com/chrisjbillington/inotify_simple/pull/37) and make it work
[ ] Make consumption, data and media paths configurable
[ ] Make web host and port configurable
