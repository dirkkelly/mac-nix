{ pkgs ? import <nixpkgs> {} }:
rec {
  # Your username here.
  username = "dirkkelly";

  gitName = "Dirk Kelly";
  gitEmail = "dk@dirkkelly.com";

  # Path to your home directory here.
  homeDirectory = "/Users/dirkkelly";

  # Mac App Store Apps
  mas = {
    # Xcode = 497799835;
  };

  # Homebrew
  taps = [];
  brews = [
    "gh"
    "libpq"
    "mkcert"
    "nss"
    "nvm" # Node 16 is deprecated, once moved beyond could use nix
    "openssl"
    "zstd"
  ];

  casks = [ 
    # "1password"
    #"google-chrome" 
    #"iterm2"
    #"rectangle"
    # "raycast"
  ];

  nix_packages = with pkgs; [
    bundix
    curl
    direnv
    docker # Still have to install Docker Desktop
    docker-compose
    fd
    foreman
    git
    gnumake
    less
    libpcap
    libxml2
    libxslt
    mysql-client
    nodenv
    pkg-config
    python2
    ripgrep
    ruby.devEnv
    vscode
    slack
    sqlite
    yarn2nix
    zstd
  ];
}
