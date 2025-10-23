{ config, pkgs, ... }:

{
  # Configuração de rede com NetworkManager
  # Backend IWD para WiFi moderno e eficiente

  networking = {
    # Nome do host
    hostName = "nixos";

    # NetworkManager para gerenciamento fácil de redes
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
      wifi.powersave = false;
    };

    # Desabilita wpa_supplicant standalone para evitar conflito com NetworkManager
    wireless = {
      enable = false;
      userControlled.enable = false;
    };

    # Firewall com porta Angular para desenvolvimento
    firewall = {
      enable = true;
      # Porta 4200 para ng serve
      allowedTCPPorts = [ 4200 ];
    };
  };

  # Ferramentas de rede
  environment.systemPackages = with pkgs; [
    networkmanager  # nmcli e nmtui
  ];
}
