# Use the latest Arch Linux image
FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    python3 \
    python-setuptools \
    base-devel \
    bluez-libs \
    gdb \
    tk \
    curl \
    sudo \
    git

# Create a build directory and set proper permissions
RUN mkdir /build && \
    chown nobody: /build

WORKDIR /build

# Download the Python 3.9 package from AUR. Use nobody because it's not possible to use makepkg with root.
RUN sudo -u nobody curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/python39.tar.gz
RUN sudo -u nobody tar xf python39.tar.gz
WORKDIR /build/python39
RUN sudo -u nobody makepkg --noconfirm
RUN pacman -U python39* --noconfirm

# Clean up
RUN rm -rf /build

# Default command to run Python
CMD ["python3"]