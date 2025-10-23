{ config, pkgs, inputs, lib, self, ... }:

{
  # Configuração principal do sistema NixOS
  # Importa todos os módulos organizados por categoria

  imports = [
    # Hardware específico
    ./hardware-configuration.nix

    # Configurações base do sistema
    "${self}/system/boot.nix"
    "${self}/system/networking.nix"
    "${self}/system/fonts.nix"
    "${self}/system/users.nix"
    "${self}/system/security.nix"
    "${self}/system/greeter/ly.nix"

    # Hardware
    "${self}/system/hardware/nvidia.nix"
    "${self}/system/hardware/bluetooth.nix"
    "${self}/system/hardware/audio.nix"

    # Programas e serviços
    "${self}/system/programs/steam.nix"
    "${self}/system/programs/docker.nix"
    "${self}/system/programs/openfortivpn.nix"

    # Sistema
    "${self}/system/xdg.nix"
    "${self}/system/packages.nix"
    "${self}/system/filesystems.nix"
    "${self}/home/programs/portainer.nix"

    # Home Manager
    inputs.home-manager.nixosModules.default
  ];

  # Overlay NUR para pacotes da comunidade
  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  # Configurações do Nix
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Garbage Collection automático
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  # Firmware proprietário para hardware
  hardware.enableRedistributableFirmware = true;

  # Localização e idioma
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

  # Layout do console
  console.keyMap = "br-abnt2";

  # Layout do teclado X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Serviços do sistema
  services = {
    ratbagd.enable = true;                # Configuração de mouse gaming
    dbus.enable = true;                    # Message bus
    power-profiles-daemon.enable = true;   # Perfis de energia
    upower.enable = true;                  # Monitoramento de bateria
    printing.enable = true;                # CUPS
    gvfs.enable = true;                    # Virtual filesystem GNOME
    tumbler.enable = true;                 # Thumbnails
  };

  # XDG Desktop Portal
  xdg.portal.enable = true;

  # Portainer para gerenciar Docker
  services.portainer = {
    enable = true;
    version = "latest";
    port = 9443;
    openFirewall = false;
  };

  # Permite pacotes não-livres
  nixpkgs.config.allowUnfree = true;

  # Versão do NixOS (não alterar)
  system.stateVersion = "25.11";

  # Log de rebuilds com timestamp
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
