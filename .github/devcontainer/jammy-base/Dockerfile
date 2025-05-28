FROM ubuntu:jammy as build
ARG EMAIL="devcontainer@arntanguy.com"
ARG NAME="jammy-devel"
ENV UBUNTU_VERSION="jammy"

RUN export DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Allow to keep apt cache between builds
RUN rm -f /etc/apt/apt.conf.d/docker-clean

# Install sudo
RUN  --mount=type=cache,target=/var/cache/apt \
  apt-get update \
 && apt-get install -y --no-install-recommends sudo ccache ripgrep rsync curl wget zsh gnupg2 gpg-agent openssh-server clangd git build-essential doxygen clang-format \
 # git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && sudo apt install git-lfs \
 && git lfs install \
 && rm -rf /var/lib/apt/lists/*


# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/zsh vscode && \
    usermod -aG sudo vscode \
    # New added for disable sudo password
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && echo "User vscode (uid=`id -u vscode`:gid=`id -g vscode`) created with passwordless sudo privileges"

# # Switch back to the official remote when https://github.com/deluan/zsh-in-docker/pull/28 is merged
# # oh-my-zsh & plugins
# RUN sh -c "$(curl -L https://raw.githubusercontent.com/balancedscorpion/zsh-in-docker/new_user/zsh-in-docker.sh)" -- \
#     -t 'bira' \
#     -p git \
#     -u vscode \
#     && echo 'source $HOME/superbuild/.devcontainer/entrypoint.sh' >> ~/.zshrc

FROM ubuntu:jammy
COPY --from=build / /
LABEL org.opencontainers.image.source=https://github.com/mc-rtc/mc-rtc-superbuild
LABEL org.opencontainers.image.description="Development environment for ubuntu jammy (base)"
LABEL org.opencontainers.image.licenses=BSD-2
# entrypoint.sh will sync this default image cache with the local folder cache upon starting the container
# This is done to allow updating the cache while working within the container
ENV CCACHE_DIR="/home/vscode/workspace/.ccache"
ENV UBUNTU_VERSION="jammy"
ENTRYPOINT ["/usr/bin/zsh", "-c"]
