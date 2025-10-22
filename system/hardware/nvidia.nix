{ config, pkgs, ... }:

{
  # Configuração de hardware NVIDIA com Intel iGPU
  # Utiliza PRIME offload para economia de energia

  # Aceleração gráfica com suporte 32-bit para jogos e aplicações Wine
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Driver NVIDIA com modesetting para compatibilidade Wayland
  hardware.nvidia = {
    # Modesetting necessário para Wayland/Niri
    modesetting.enable = true;

    # Gerenciamento de energia para suspensão
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Driver proprietário (closed source)
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # PRIME offload: Intel iGPU padrão, NVIDIA sob demanda
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # Xserver configurado para ambos os drivers
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" "nvidia" ];
  };

  # Parâmetros do kernel para preservar memória de vídeo na suspensão
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  # Serviços systemd para suspensão/hibernação com NVIDIA
  systemd.services = {
    nvidia-suspend.wantedBy = [ "suspend.target" ];
    nvidia-hibernate.wantedBy = [ "hibernate.target" ];
    nvidia-resume.wantedBy = [ "suspend.target" ];
  };

  # Utilitários para diagnóstico de GPU
  environment.systemPackages = with pkgs; [
    glxinfo    # Informações OpenGL
    pciutils   # lspci para identificar hardware
  ];
}
