FROM mcr.microsoft.com/devcontainers/base:bookworm

RUN apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# install doppler cli
RUN curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add - && \
  echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list && \
  sudo apt-get update && sudo apt-get install -y doppler

USER vscode

# install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0 && \
  # configure for bash shell
  echo '. "$HOME/.asdf/asdf.sh"' >> $HOME/.bashrc && \
  echo '. "$HOME/.asdf/completions/asdf.bash"' >> $HOME/.bashrc && \
  # configure for zsh shell
  echo '. "$HOME/.asdf/asdf.sh"' >> $HOME/.zshrc && \
  echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> $HOME/.zshrc && \
  echo 'autoload -Uz compinit && compinit' >> $HOME/.zshrc
