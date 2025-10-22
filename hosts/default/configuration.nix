{ config, pkgs, inputs, lib, self, ... }:

{
  # Configuração principal do sistema NixOS
  # Importa todos os módulos organizados por categoria

  imports = [
    ./hardware-configuration.nix
    "${self}/system/boot.nix"
    "${self}/system/networking.nix"
    "${self}/system/fonts.nix"
    "${self}/system/users.nix"
    "${self}/system/security.nix"
    "${self}/system/hardware/nvidia.nix"
    "${self}/system/hardware/bluetooth.nix"
    "${self}/system/hardware/audio.nix"
    "${self}/system/programs/steam.nix"
    "${self}/system/programs/docker.nix"
    "${self}/system/programs/openfortivpn.nix"
    "${self}/system/xdg.nix"
    "${self}/system/packages.nix"
    "${self}/system/filesystems.nix"
    "${self}/home/programs/portainer.nix"
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  hardware.enableRedistributableFirmware = true;

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  console.keyMap = "br-abnt2";

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  services = {
    ratbagd.enable = true;
    dbus.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };

  xdg.portal.enable = true;

  services.portainer = {
    enable = true;
    version = "latest";
    port = 9443;
    openFirewall = false;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

  system.activationScripts.logRebuildTime = {
    text = ''
      LOG_FILE="/var/log/nixos-rebuild-log.json"
      TIMESTAMP=$(date "+%d/%m")
      GENERATION=$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]\+')

      echo "{\"last_rebuild\": \"$TIMESTAMP\", \"generation\": $GENERATION}" > "$LOG_FILE"
      chmod 644 "$LOG_FILE"
    '';
  };
}
