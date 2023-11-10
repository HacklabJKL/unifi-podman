FROM quay.io/official-images/debian:bookworm

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install systemd-sysv apt-utils ca-certificates apt-transport-https
RUN apt-get -y install usrmerge procps
RUN apt-get clean

# Enable some services
RUN systemctl enable systemd-networkd

# Unifi part
COPY --chown=root:root template /
RUN apt-get update
RUN apt-get -y install --download-only unifi

# TODO Merge template and template2 later
COPY --chown=root:root template2 /
RUN systemctl enable container-initial
RUN systemctl set-default multi-user.target
RUN systemctl mask console-getty

# Initial configuration is done by container-initial.service after
# first boot starts.

CMD [ "/sbin/init" ]

EXPOSE 8080

# The only thing we want to keep is backups, since Unifi can restore
# basically all its state from there.
VOLUME "/var/lib/unifi/backup"
