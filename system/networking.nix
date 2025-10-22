{ config, pkgs, ... }:

{
  # Configuração de rede com NetworkManager
  # Backend IWD para WiFi moderno e eficiente

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      wifi.powersave = false;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 4200 ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanager
  ];
}
