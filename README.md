# A Paperless-ngx port for FreeBSD
The port will install [paperless-ngx](https://paperless-ngx.com) on [FreeBSD](https://www.freebsd.org/).

# How to update to a new paperless-ngx release
These are instructions for myself, but feel free to create a PR if I have been slacking in updating the port.

1. Run `make clean` to start off with a clean state
1. Update the value of `DISTVERSION` in **Makefile**
1. Run `make makesum` to update **distinfo**
1. Run `make extract` to have the new release extracted to `WRKDIR ` (defaults to **work**)
1. ~~Update the versions of the `numpy`, `scikit-learn` and `scipy` ports in **Makefile** according to the new values in **requirements.txt**~~ (currently `paperless-ngx` uses versions higher than the ones available as FreeBSD ports, so skip this)
1. Update all **files/patch-\*** files. As per the [Porter's Handbook](https://docs.freebsd.org/en/books/porters-handbook/slow-porting/#slow-patch) instructions:
    1. For each file **file** to patch:
        1. Copy the file to be patched: `cp file file.orig`
        1. Edit **file** replaying the updated changes on the existing **files/patch-file**
    1. Run `make makepatch` to generate updated patch files in the **files** directory
1. Run `make stage`
1. Update **pkg-plist**:
    1. Run `make makeplist > newplist`
    1. In **newplist**:
    	1. Replace all occurrences of `%%USER%%` with `paperless`
    	1. Delete the first line (`/you/have/to/check/what/makeplist/gives/you`)
    	1. Delete the lines for sample files (`*.sample`)
    	1. Delete the lines for rc scripts (`etc/rc.d/*`)
    	1. Copy the block of lines that start with a `@` at the begginning of **pkg-plist** to the beginning of **newplist**
    1. Replace **pkg-plist** with **newplist**

# To-do
- [X] Install files to `/opt/paperless`
- [X] Use gunicorn instead of the development HTTP server
- [X] Update to v2
- [ ] Make web host and port configurable
- [ ] Make consumption, data and media paths configurable
- [ ] Make NLTK optional?
- [ ] Install [jbig2enc](https://ocrmypdf.readthedocs.io/en/latest/jbig2.html) encoder
- [ ] Use inotify instead of polling the consumption folder: [inotify_simple PR](https://github.com/chrisjbillington/inotify_simple/pull/37) and make it work
- [ ] Set `PAPERLESS_SECRET_KEY` to a random sequence of characters. It's used for authentication. Failure to do so allows third parties to forge authentication credentials.
- [ ] Set `PAPERLESS_OCR_LANGUAGE` to the language most of your documents are written in
- [ ] Set `PAPERLESS_TIME_ZONE` to your local time zone.
