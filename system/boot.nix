{ config, pkgs, ... }:

{
  # Configuração de boot com systemd-boot
  # Kernel mais recente e módulos para v4l2loopback (DroidCam)

  boot = {
    # Bootloader UEFI com systemd-boot
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      # Permite modificar variáveis EFI
      efi.canTouchEfiVariables = true;
    };

    # Kernel mais recente para melhor suporte de hardware
    kernelPackages = pkgs.linuxPackages_latest;

    # Parâmetros de boot
    kernelParams = [
      # Força resolução e refresh rate do display interno
      "video=eDP-1:2880x1800@120"
    ];

    # Módulos do kernel
    kernelModules = [
      "v4l2loopback"  # Câmera virtual para DroidCam
      "i2c-dev"       # Controle de brilho via DDC
    ];

    # Módulos disponíveis no initrd
    initrd.availableKernelModules = [ "i2c-dev" ];

    # Pacotes extras do kernel
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    # Configuração do módulo v4l2loopback
    extraModprobeConfig = ''
      options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1
    '';
  };
}
