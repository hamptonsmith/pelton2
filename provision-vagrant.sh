#!/bin/bash

function provisionVagrant() {
    set -e

    cd $HOME

    apt-get -yqq update

    # We'll use `git` to download / update pelton.
    # `install` is a pelton installer dependency.
    apt-get -yqq install git

    if [[ -d pelton ]]; then
        cd pelton
        git pull
    else
        git clone https://github.com/hamptonsmith/pelton2.git pelton
        cd pelton
    fi

    # Install/update pelton. This also installs docker, jq, and microk8s.
    APT_CMD='apt-get -yqq' ./bin/pelton-burrow

    # Get vagrant user added to microk8s group for easy command line use.
    usermod -a -G microk8s vagrant
    chown -f -R vagrant ~/.kube

    if ! grep '# Alias kubectl' /home/vagrant/.bashrc >/dev/null; then
        echo 'alias kubectl="microk8s kubectl"   # Alias kubectl' \
                > /home/vagrant/.bashrc
    fi

    # Docker without sudo
    if [[ -z "$(getent group docker)" ]]; then
        groupadd docker
    fi
    usermod -aG docker vagrant

    DND_FILE="/home/vagrant/.config/pelton/environment/namespaces/default"
    DND_FILE="$DND_FILE/do-not-delete"
    if [[ ! -f "$DND_FILE" ]]; then

        # All clusters have a `service/kubernetes` in the default namespace
        # that won't appear in our manifests. Let's add it to our ignore
        # list so we don't delete it.

        mkdir -p $(dirname "$DND_FILE")
        echo 'service/kubernetes' > "$DND_FILE"
        chown -R vagrant:vagrant /home/vagrant/.config

    fi
}

provisionVagrant
