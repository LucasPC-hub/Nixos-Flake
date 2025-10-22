{ config, pkgs, ... }:

{
  # Configuração de fontes do sistema
  # Inclui Nerd Fonts, Noto e Material Icons

  fonts.packages = with pkgs; [
    # Fontes sans-serif modernas
    fira-sans
    roboto

    # Nerd Fonts para terminais e editores
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.fantasque-sans-mono

    # Fonte monospace para desenvolvimento
    jetbrains-mono

    # Noto para cobertura Unicode completa
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans   # Chinês, Japonês, Coreano
    noto-fonts-cjk-serif

    # Ícones Material Design
    material-symbols
    material-icons
  ];
}
