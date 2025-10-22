{ config, pkgs, inputs, ... }:

{
  # Configuração de usuários e home-manager
  # Define grupos de permissões e shell padrão

  users.groups.i2c = {};
  users.groups.plugdev = {};

  users.users.lpc = {
    isNormalUser = true;
    description = "lpc";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "plugdev"
      "i2c"
      "bluetooth"
      "docker"
    ];
  };

  programs.fish.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    verbose = true;
    users = {
      "lpc" = import ../hosts/default/home.nix;
    };
  };
}
