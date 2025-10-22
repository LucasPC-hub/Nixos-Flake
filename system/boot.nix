{ config, pkgs, ... }:

{
  # Configuração de boot com systemd-boot
  # Kernel mais recente e módulos para v4l2loopback (DroidCam)

  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "video=eDP-1:2880x1800@120"
    ];
    kernelModules = [ "v4l2loopback" "i2c-dev" ];
    initrd.availableKernelModules = [ "i2c-dev" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1
    '';
  };
}
