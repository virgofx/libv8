# libv8

[Packagecloud-Stable-#.#.#.#]
[Packagecloud-Beta-#.#.#.#]
[Packagecloud-Dev-#.#.#.#]

## Overview

This repository is used to trigger up-to-date component builds for the V8 library which 
can be used by embedders and other applications. This library exists because
the default V8 libraries are out-of-date with respect to the fast moving pace
of V8.

## V8 Installation

The V8 library is hosted via [Packagecloud](https://packagecloud.io/libv8). Determine
the V8 Channel you prefer to install (Stable, Beta, Dev) and then follow the instructions 
on Packagecloud for your specific operating system/distro. 

1. Select your channel: **Stable**, **Beta**, **Dev**
    > Recommended Channel: **Stable**
2. Visit https://packagecloud.io/libv8 and click the link for your desired channel.
3. Install the repository into your OS. This can be done by the various quick 
   install steps provided via the *Installation* tab. Alternatively, you can
   download the appropriate GPG keys and integrate into your custom.
4. Install desired V8 packages using your operating system's default package manager.
   |   |   |
   |---|---|
   | **libv8** | Main library files |
   | **libv8-dev** | Development headers |
   | **libv8-dbg** | Debug symbols |

## Automated Builds

Daily builds are triggered in Travis CI in a Ubuntu 14.04 virtual machine. Builds for
each of the "Stable", "Beta", and "Dev" channels are triggered and only built/deployed
if there exists a newer version as specified via the
[Chromium V8 Chart](https://omahaproxy.appspot.com).

Since building V8 requires updated and specific versions of packages, the actual build
process takes place inside a docker container where the output files are mapped to the 
underying host as a volume. 



* Stable - 6.8.275.26
* Beta - 6.9.427.14
* Dev - 7.0.158

## Versions

Stable versions are detected from:






libv8
    /usr/lib/libv8.so.3.14.5 --> /usr/lib/libv8.so
    /usr/share/doc/libv8-3.14.5/
        AUTHORS
        changelog.Debian.gz
        copyright

libv8-dev


libv8-dbg


