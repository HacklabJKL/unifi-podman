# unifi-podman

Ubiquiti Unifi container for Podman

## Design principles and notes

We aim to be administrator friendly and target for Intended for
small-scale installation such as home or a club room. Easy
installation and maintenance is important. In summary:

* Monolithic all-in-one Unifi container
* Podman is used because its advanced network namespace features
* Restore from Unifi backup file required in case of an update

The container is monolithic. No external MongoDB.  We don't use
MongoDB in production, so Unifi is the only user of that MongoDB
instance. In short, we don't need an orchestra, we just want the Epic
Sax Guy.

This has a side effect, which is not anti-feature for us but might be
to you: The database is throwaway and in case you recreate the
container, you must use Unifi restore functionality to get the
configuration back.

Unifi makes backups once per month and they are stored on a separate
volume. You can also manually ask for a backup from Unifi.

We require Podman instead of Docker since Podman has better support
for network namespaces, allowing your management interface to be
delegated to this container, therefore avoiding port forwarding mess
which is commonplace in other Unifi containers out there.

## Installation

First, make sure you have Podman installed.

In this directory, run:

```sh
podman build -t unifi .
```

To start the container the first time:

```sh
podman run --hostname unifi --name unifi -p 127.0.0.1:8080:8080 unifi
```

To generate systemd job for starting and stopping the container:

TODO
