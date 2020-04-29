FROM gitpod/workspace-full
                    
USER gitpod

# Install custom tools, runtime, etc. using apt-get
# More information: https://www.gitpod.io/docs/config-docker/

RUN sudo apt-get update && \
    sudo apt-get install -y apt-transport-https protobuf-compiler redis && \
    sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
    sudo apt-get update && \
    sudo apt-get install -y dart && \
    echo "export PATH=\"\$PATH:/usr/lib/dart/bin:\$HOME/.pub-cache/bin\"" >> $HOME/.bashrc && \
    git clone https://github.com/flutter/flutter.git -b dev && \
    ./flutter/bin/flutter upgrade && \
    ./flutter/bin/flutter doctor -v && \
    ./flutter/bin/flutter config --enable-web && \
    echo "export PATH=\$PATH:$PWD/flutter/bin" >> $HOME/.bashrc && \
    sudo rm -rf /var/lib/apt/lists/*
