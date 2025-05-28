FROM ghcr.io/arntanguy/devcontainers/jammy-base:latest as build
ARG EMAIL="devcontainers@arntanguy.github.com"
ARG NAME="devcontainers"

RUN export DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Allow to keep apt cache between builds
RUN rm -f /etc/apt/apt.conf.d/docker-clean

# Install sudo
RUN  --mount=type=cache,target=/var/cache/apt \
  apt-get update \
 && apt-get install -y --no-install-recommends doxygen lcov cppcheck clang-format jekyll \
 # git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && sudo apt install git-lfs \
 && git lfs install \
 && git config --global user.email "${EMAIL}" && git config --global user.name "${NAME}" \
 && rm -rf /var/lib/apt/lists/*

FROM ghcr.io/arntanguy/devcontainers/jammy-base:latest
COPY --from=build / /
LABEL org.opencontainers.image.source=https://github.com/arntanguy/devcontainers
LABEL org.opencontainers.image.description="PID Development environment for ubuntu jammy"
LABEL org.opencontainers.image.licenses=BSD-2
# entrypoint.sh will sync this default image cache with the local folder cache upon starting the container
# This is done to allow updating the cache while working within the container
ENV CCACHE_DIR="/home/vscode/workspace/.ccache"
ENV UBUNTU_VERSION="jammy"
ENTRYPOINT ["/usr/bin/zsh", "-c"]
