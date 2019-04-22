FROM nixos/nix

RUN \
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager && \
  nix-channel --update

RUN nix-shell '<home-manager>' -A install
ADD ./dotfiles/nixpkgs/ /root/.config/nixpkgs/
ADD ./dotfiles/config.nix /root/.nixpkgs/
RUN home-manager switch

#RUN nix-build -A pythonFull '<nixpkgs>'

# FROM debian:stretch
#
# RUN \
#   apt-get update && \
#   apt-get install -y curl bzip2 sudo less
#
# RUN \
#   useradd -s /bin/bash -m user && \
#   usermod -a -G sudo user && \
#   echo "user:user" | chpasswd
#
# RUN \
#   mkdir -m 0755 /nix && \
#   chown user:user /nix
#
# RUN \
#   mkdir -p /etc/nix && \
#   echo 'sandbox = false' > /etc/nix/nix.conf
#
# USER user
# ENV USER=user
# WORKDIR /home/user
# RUN touch /home/user/.bash_profile
#
# RUN bash -c "bash <(curl https://nixos.org/nix/install)"
#
# # ENTRYPOINT /bin/bash --login
# ENTRYPOINT bash -l -c bash
