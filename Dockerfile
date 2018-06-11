# docker build -t accetto/ubuntu-vnc-xfce-firefox-plus .
# docker build --build-arg BASETAG=rolling -t accetto/ubuntu-vnc-xfce-firefox-plus:rolling .
# docker build --build-arg ARG_VNC_USER=root:root -t accetto/ubuntu-vnc-xfce-firefox-plus:root .
# docker build --build-arg ARG_VNC_RESOLUTION=1360x768 -t accetto/ubuntu-vnc-xfce-firefox-plus .
# docker build --build-arg BASETAG=dev -t accetto/ubuntu-vnc-xfce-firefox-plus:dev .

ARG BASETAG=latest

FROM accetto/ubuntu-vnc-xfce:${BASETAG} as stage-install

ENV REFRESHED_AT 2018-06-11

### Be sure to use root user
USER 0

### 'apt-get clean' runs automatically
RUN apt-get update && apt-get install -y \
        firefox \
    && rm -rf /var/lib/apt/lists/*

FROM stage-install as stage-config

### Arguments can be provided during build
ARG ARG_VNC_USER

ENV VNC_USER=${ARG_VNC_USER:-headless:headless}

WORKDIR $HOME
SHELL ["/bin/bash", "-c"]

COPY [ "./src/firefox.desktop", "./Desktop/" ]

### Put all user preferences you want to force administratively into the file 'all-accetto.js'.
### The preferences will be forced for each session in all profiles.
### The VNC user ('headles:headless' by default) will get permissions to modify the file.
### The file is currently empty. The fix for issue #2 has been moved to 'user.js'.
COPY [ "./src/all-accetto.js", "/usr/lib/firefox/browser/defaults/preferences/" ]

### Create the default profile folder and put the file with default preferences there.
### The preferences will be forced for each session, but only in the profile containing the file.
### The VNC user ('headles:headless' by default) will get permissions to modify or delete the file.
### There will be also a backup copy of the proto-profile.
RUN mkdir \
    ./.mozilla \
    ./.mozilla/firefox \
    ./.mozilla/firefox/profile0.default

COPY [ "./src/profiles.ini", "./.mozilla/firefox/" ]
COPY [ "./src/user.js", "./.mozilla/firefox/profile0.default/" ]
COPY [ "./src/create_user_and_fix_permissions.sh", "./src/patch_vnc_startup.*", "./" ]

### 'sync' mitigates automated build failures
RUN \
    cp -r ./.mozilla/firefox/ $HOME/firefox.backup/ \
    && chmod +x \
        ./create_user_and_fix_permissions.sh \
        ./Desktop/firefox.desktop \
        ./patch_vnc_startup.sh \
    && sync \
    && ./patch_vnc_startup.sh \
    && ./create_user_and_fix_permissions.sh $STARTUPDIR $HOME \
    && rm \
        ./*.sh \
        ./patch_vnc_startup.txt

FROM stage-config as stage-final

LABEL \
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop and customizable Firefox" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container with customizable Firefox" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc, firefox"

### Arguments can be provided during build
ARG ARG_VNC_BLACKLIST_THRESHOLD
ARG ARG_VNC_BLACKLIST_TIMEOUT
ARG ARG_VNC_RESOLUTION

ENV \
  VNC_BLACKLIST_THRESHOLD=${ARG_VNC_BLACKLIST_THRESHOLD:-20} \
  VNC_BLACKLIST_TIMEOUT=${ARG_VNC_BLACKLIST_TIMEOUT:-0} \
  VNC_RESOLUTION=${ARG_VNC_RESOLUTION:-1024x768} 

### Switch to non-root user
USER $VNC_USER
