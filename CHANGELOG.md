# CHANGELOG

## accetto/ubuntu-vnc-xfce-firefox-plus

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][this-wiki]

***

### Version 18.10

- Fixed **Issue #7** (Problem with foreground mode) inherited from the [base image][accetto-github-ubuntu-vnc-xfce]
  - supported startup options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`
  - getting help: `docker run --rm accetto/ubuntu-vnc-xfce --help`
  - README file is extended

### Version 18.06

- Dockerfile redesigned
  - multi-staged and explicit
  - helper installation scripts mostly removed
- Some other changes inherited from the base image [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
  - standard *Xfce* desktop, incl. initial panel configuration on the first start
  - editor **leafpad** replaced by more advanced but still lite [mousepad][mousepad]
  - **pulseaudio** and **pavucontrol** not purged any more
- Firefox updated

### Version 18.05.2

- Dockerfiles - build arguments and environment variables interaction redesigned
- Default **VNC_RESOLUTION=1024x768** and it can be set also through build arguments

### Version 18.05.1

- Firefox Quantum updated to version **60.0** (64-bit)

### Version 18.05

- This is the first version after splitting from the former common base repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
- Resources for base Ubuntu/VNC images and images with configurable Firefox split into separate GitHub repositories, consequently
  - README, CHANGELOG and Wiki are not common any more
  - Resources for base images moved to repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
  - Resources for images with default Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox][accetto-github-ubuntu-vnc-xfce-firefox]
  - This image contains Firefox installation with pre-configuration support

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/wiki

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-firefox

[mousepad]: https://github.com/codebrainz/mousepad
