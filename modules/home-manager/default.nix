{ pkgs, nixpkgs, ... }:
  let
    config = (import ../../config.nix { inherit pkgs; });
  in
{
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";

  # specify my home-manager configs
  home.packages = config.nix_packages;

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nano";
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.eza.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.initExtra = ''
    export GEM_HOME="$HOME/.gem"
    export HOMEBREW_PREFIX="/opt/homebrew"

    eval "$(direnv hook zsh)"

    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/usr/local/opt/libpq/bin:$PATH"
    export PATH="/usr/local/opt/mysql-client/bin:$PATH"

    export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    export NODE_VERSIONS_PREFIX=v
    export NODE_VERSIONS=$NVM_DIR/versions/node/

    export PGHOST="localhost"
    export PGUSER="postgres"
  '';
  programs.zsh.shellAliases = {
    ls = "ls --color=auto -F";
    nixswitch = "nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake ~/src/mac-nix#mbp-dev";
    nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    gap = "git add -p";
  };
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.git.enable = true;
  programs.git.userName = config.gitName;
  programs.git.userEmail = config.gitEmail;

  programs.ssh = {
    enable = true;
    extraConfig = (builtins.readFile ./dotfiles/sshConfig );
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;
  home.file.".gitconfig".source = ./dotfiles/gitconfig;
  home.file.".my.cnf".source = ./dotfiles/my.cnf;
  home.file."pgpass".source = ./dotfiles/pgpass;
}