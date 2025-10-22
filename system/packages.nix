{ config, pkgs, inputs, ... }:

{
  # Pacotes essenciais do sistema
  # Ferramentas de desenvolvimento, utilitários e serviços base

  environment.systemPackages = with pkgs; [
    ly
    yarn
    git
    arrpc
    swww
    gnome-themes-extra
    xwayland
    ffmpeg
    mesa
    libva
    libva-utils
    nh
    base16-schemes
    ddcutil
    os-prober
    hidapi
    tree
    piper
  ];
}
