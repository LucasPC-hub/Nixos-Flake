{ config, pkgs, ... }:

{
  # Configuração de hardware NVIDIA com Intel iGPU
  # Utiliza PRIME offload para economia de energia

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  systemd.services = {
    nvidia-suspend.wantedBy = [ "suspend.target" ];
    nvidia-hibernate.wantedBy = [ "hibernate.target" ];
    nvidia-resume.wantedBy = [ "suspend.target" ];
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    pciutils
  ];
}
