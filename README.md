> [!WARNING]  
> There is now a port of Paperless-ngx for FreeBSD:
> https://www.freshports.org/deskutils/py-paperless-ngx/
> 
> It supercedes this port, both in quality and functionality.
> 
> Although it is only available for FreeBSD 14 and 15, it is possible to get it installed and running on FreeBSD 13:
> https://tinsuke.wordpress.com/2024/04/20/how-to-install-py-paperless-ngx-on-freebsd-13/
>
> Work on this port will stop.

# A Paperless-ngx port for FreeBSD
The port will install [paperless-ngx](https://paperless-ngx.com) on [FreeBSD](https://www.freebsd.org/).

# Installation

## Pre-built

1. Download a pre-packaged **.pkg** file from https://github.com/tinsukE/paperless-ngx-freebsd-port/releases.
2. Install it with `pkg install file`

## From source

Install directly from this repo's code:
```
git clone https://github.com/tinsukE/paperless-ngx-freebsd-port
cd paperless-ngx-freebsd-port
make install
```

# How to run

1. Configure the service to start automatically: `sysrc paperless_enable=YES`
1. Create a user: `/usr/local/bin/paperless_manage createsuperuser`
1. Optional: configure Paperless-ngx by editing `/opt/paperless/paperless.conf`
1. Start it: `service paperless start`

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
