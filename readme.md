# Battlefield 1942 server

Hosts file patched for bf1942.sk.

## Quickstart

```
# Custom config
docker run -p 14567:14567 -e BFSM=true -e chipu/bf1942-server \
    -v myconfig.con:/bf1942/mods/bf1942/settings/serversettings.con

# Config using env
docker run -p 14567:14567 -e BFSM=true -e GAME_SERVERNAME="MyServer" chipu/bf1942-server
```

## Configuration
Mount a custom /bf1942/mods/bf1942/settings/serversettings.con

You can also use env-vars for server-settings:
Example "-e GAME_SERVERPASSWORD=Secret" replaces game.serverPassword in serversettings.con
The variable have to exist in the settings file or it will be ignored.

## BFSM
You can control BFSM with the following env. vars:
- BFSM=true # Enable BFSM
- BFSM_PORT=22999 # Listen port

## TOOD
- Maybe run BFSM in a separate docker-container
