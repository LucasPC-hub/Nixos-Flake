{ config, pkgs, ... }:

{
  # Configuração de segurança e permissões
  # Polkit, udev rules para dispositivos Logitech

  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
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

  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", MODE="0660", GROUP="plugdev"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
  '';

  services.udev.packages = with pkgs; [ rwedid solaar ];

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    glib
    solaar
  ];
}
