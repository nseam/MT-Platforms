# Meta Trader 4/5 platform packager.

## What it does

It downloads current MetaTrader 4.x and 5.x builds and releases them in the 4.x and 5.x tags as downloadable assets. It is an automated process, you don't need to do anything but configure AppVeyor and GitHub Personal Access Token described later.

## Requirements

* https://www.appveyor.com/

* GitHub Personal Access Token (described later)

## How to run it

In order to run platform packager you need to configure AppVeyor to build this repository.

To build packages and release them in their respective tags, please ensure you put secured GitHub access token into `deploy.auth_token` variable inside `appveyor.yml` script. If you need more information, just look at that variable in `appveyor.yml` file, it contain required commentary.

## Debugging

If you experience `AutoHotkey` to hang itself for more than 2-5min you may try to connect to container via RDP to see what's going on.

Just add following lines into `appveyor.yml` script:

```
init:
- ps: iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/appveyor/ci/master/scripts/enable-rdp.ps1'))
```

You also need to specify password for RDP, which have to be at least 6 characters, with big and small letters and special symbol, e.g.,:

```
environment:
  APPVEYOR_RDP_PASSWORD: Yourpass2$
```

When such build starts, it will give you information about IP and port you need to connect to, e.g.,

```
Remote Desktop connection details:
  Server: 67.225.165.198:33833
  Username: appveyor
```

## Issues

Double check if such issue isn't already opened there: https://github.com/EA31337/MT-Platforms/issues.

If not, please add new issue and describe in details problems you experienced during build.