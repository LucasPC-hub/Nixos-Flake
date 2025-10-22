{ config, pkgs, inputs, ... }:

{
  # Configuração de usuários e home-manager
  # Define grupos de permissões e shell padrão

  # Grupos customizados para permissões de hardware
  users.groups = {
    i2c = {};      # Controle de brilho via DDC
    plugdev = {};  # Dispositivos USB e Logitech
  };

  # Usuário principal
  users.users.lpc = {
    isNormalUser = true;
    description = "lpc";
    # Fish como shell padrão
    shell = pkgs.fish;

    # Grupos de permissões
    extraGroups = [
      "networkmanager"  # Gerenciar redes
      "wheel"           # Sudo
      "video"           # Controle de GPU e brilho
      "input"           # Dispositivos de entrada
      "plugdev"         # Dispositivos USB
      "i2c"             # Controle DDC
      "bluetooth"       # Bluetooth
      "docker"          # Docker sem sudo
    ];
  };

  # Habilita Fish globalmente
  programs.fish.enable = true;

  # Configuração do home-manager
  home-manager = {
    # Usa pkgs do sistema ao invés de baixar separado
    useGlobalPkgs = true;
    # Instala pacotes no perfil do usuário
    useUserPackages = true;
    # Passa inputs do flake para home-manager
    extraSpecialArgs = { inherit inputs; };
    # Modo verbose para debugging
    verbose = true;

    # Configuração por usuário
    users = {
      "lpc" = import ../hosts/default/home.nix;
    };
  };
}
