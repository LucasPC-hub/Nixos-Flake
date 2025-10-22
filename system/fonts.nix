{ config, pkgs, ... }:

{
  # Configuração de fontes do sistema
  # Inclui Nerd Fonts, Noto e Material Icons

  fonts.packages = with pkgs; [
    fira-sans
    roboto
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.fantasque-sans-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    material-symbols
    material-icons
  ];
}
