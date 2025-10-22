{ config, pkgs, inputs, ... }:

{
  # Pacotes essenciais do sistema
  # Ferramentas de desenvolvimento, utilitários e serviços base

  environment.systemPackages = with pkgs; [
    # Display Manager
    ly  # TUI greeter minimalista

    # Desenvolvimento
    yarn  # Gerenciador de pacotes Node.js
    git   # Controle de versão

    # Wayland e Desktop
    arrpc                # Discord Rich Presence
    swww                 # Daemon de wallpaper
    gnome-themes-extra   # Temas GTK
    xwayland             # Compatibilidade X11

    # Multimídia
    ffmpeg       # Conversão de áudio/vídeo
    mesa         # Drivers OpenGL
    libva        # Aceleração de vídeo
    libva-utils  # Utilitários VA-API

    # Utilitários
    nh              # Helper Nix com UI
    base16-schemes  # Esquemas de cores
    ddcutil         # Controle DDC de monitores
    os-prober       # Detecção de outros SO
    hidapi          # API HID para dispositivos
    tree            # Visualizador de árvore de diretórios
    piper           # Configuração de mouse gaming
  ];
}
