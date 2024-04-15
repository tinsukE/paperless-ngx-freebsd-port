# A Paperless-ngx port for FreeBSD
The port will install [paperless-ngx](https://paperless-ngx.com) on [FreeBSD](https://www.freebsd.org/).

# To-do
- [X] Install files to `/opt/paperless`
- [X] Use gunicorn instead of the development HTTP server
- [ ] Update to v3
- [ ] Make web host and port configurable
- [ ] Make consumption, data and media paths configurable
- [ ] Make NLTK optional?
- [ ] Install [jbig2enc](https://ocrmypdf.readthedocs.io/en/latest/jbig2.html) encoder
- [ ] Use inotify instead of polling the consumption folder: [inotify_simple PR](https://github.com/chrisjbillington/inotify_simple/pull/37) and make it work
- [ ] Set `PAPERLESS_SECRET_KEY` to a random sequence of characters. It's used for authentication. Failure to do so allows third parties to forge authentication credentials.
- [ ] Set `PAPERLESS_OCR_LANGUAGE` to the language most of your documents are written in
- [ ] Set `PAPERLESS_TIME_ZONE` to your local time zone.
