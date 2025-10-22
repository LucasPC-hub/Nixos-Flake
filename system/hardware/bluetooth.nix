{ config, pkgs, ... }:

{
  # Configuração de Bluetooth otimizada para Intel AX211
  # Inclui ajustes para conectividade estável e baixa latência

  # Configuração principal do Bluetooth
  hardware.bluetooth = {
    enable = true;
    # Liga automaticamente ao boot para reconexão de dispositivos
    powerOnBoot = true;

    settings = {
      General = {
        # Modo dual para suporte BR/EDR e LE
        ControllerMode = "dual";
        # Conexão rápida para melhor experiência
        FastConnectable = true;
        # Timeout aumentado para dispositivos lentos
        ConnectTimeout = 60;
      };

      Policy = {
        # Habilita adaptador automaticamente
        AutoEnable = true;
      };

      # Configurações Low Energy otimizadas para fones Galaxy Buds
      LE = {
        MinConnectionInterval = 30;
        MaxConnectionInterval = 50;
        # Latência zero para áudio
        ConnectionLatency = 0;
        ConnectionSupervisionTimeout = 420;
      };
    };
  };

  # Parâmetros do kernel para estabilidade do Bluetooth
  boot.kernelParams = [
    # Desabilita ERTM que causa problemas com alguns dispositivos
    "bluetooth.disable_ertm=1"
  ];

  # Pacotes bluez para dbus
  services.dbus.packages = with pkgs; [ bluez ];

  # Regras udev para gerenciamento de energia e reset do adaptador
  services.udev.extraRules = ''
    # Desabilita autosuspend para Intel AX211 (evita desconexões)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0033", TEST=="power/control", ATTR{power/control}="on"

    # Reset automático do HCI ao adicionar dispositivo
    ACTION=="add", SUBSYSTEM=="bluetooth", KERNEL=="hci[0-9]*", RUN+="${pkgs.bluez}/bin/hciconfig %k reset"
  '';

  # Ferramentas Bluetooth
  environment.systemPackages = with pkgs; [
    bluez  # Stack Bluetooth
  ];
}
