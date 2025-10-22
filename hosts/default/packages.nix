{
  pkgs,
  inputs,
  ...
}:
with pkgs;
let
  # Define custom packages
  # dgop = callPackage ../../home/programs/dgop.nix {}; # Agora vem do flake do quickshell
in
[
  # Applications
  protonplus
  lutris
  zoom
  prismlauncher
  nautilus
  file-roller
  eog
  evince
  obsidian
  galaxy-buds-client
  # TUI
  btop
  fish
  rmpc
  # Desktop
  nwg-look
  walker
  # Development
  remmina
  jetbrains-toolbox
  rustup
  gcc
  gh
  nixfmt-rfc-style
  nixpkgs-fmt
  zed-editor
  nodePackages.npm
  mockoon
  insomnia
  # Utilities
  jq
  libnotify
  wl-clipboard
  rar
  unzip
  droidcam
  gpu-screen-recorder
  mpv
  cava
  kitty
  lazydocker
  kdePackages.dolphin
  yazi

  # Quickshell stuff
  qt6Packages.qt5compat
  libsForQt5.qt5.qtgraphicaleffects
  kdePackages.qtbase
  kdePackages.qtdeclarative
  kdePackages.qtstyleplugin-kvantum
  # Niri
  xwayland-satellite
  wl-clipboard
]
