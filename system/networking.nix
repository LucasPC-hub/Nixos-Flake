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
      # IWD é mais moderno e eficiente que wpa_supplicant
      wifi.backend = "iwd";
      # Desabilita powersave para melhor latência
      wifi.powersave = false;
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
