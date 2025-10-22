{ config, pkgs, ... }:

{
  # Configuração de segurança e permissões
  # Polkit, udev rules para dispositivos Logitech

  # PolicyKit para elevação de privilégios
  security.polkit.enable = true;

  # Agente de autenticação gráfico do GNOME
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    # Inicia junto com sessão gráfica
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Regras udev para dispositivos específicos
  services.udev.extraRules = ''
    # Receptores Logitech Unifying/Lightspeed
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", MODE="0660", GROUP="plugdev"

    # Todos os dispositivos hidraw para acesso de usuário
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
  '';

  # Pacotes udev adicionais
  services.udev.packages = with pkgs; [
    rwedid  # Leitura/escrita de EDID
    solaar  # Gerenciador Logitech
  ];

  # Suporte a dispositivos Logitech wireless
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Ferramentas de segurança e gerenciamento
  environment.systemPackages = with pkgs; [
    polkit_gnome  # Agente de autenticação
    glib          # Bibliotecas GLib
    solaar        # Interface Logitech
  ];
}
