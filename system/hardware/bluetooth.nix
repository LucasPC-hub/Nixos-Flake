{ config, pkgs, ... }:

{
  # Configuração de Bluetooth otimizada para Intel AX211
  # Inclui ajustes para conectividade estável e baixa latência

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = true;
        ConnectTimeout = 60;
      };

      Policy = {
        AutoEnable = true;
      };

      LE = {
        MinConnectionInterval = 30;
        MaxConnectionInterval = 50;
        ConnectionLatency = 0;
        ConnectionSupervisionTimeout = 420;
      };
    };
  };

  boot.kernelParams = [
    "bluetooth.disable_ertm=1"
  ];

  services.dbus.packages = with pkgs; [ bluez ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0033", TEST=="power/control", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="bluetooth", KERNEL=="hci[0-9]*", RUN+="${pkgs.bluez}/bin/hciconfig %k reset"
  '';

  environment.systemPackages = with pkgs; [
    bluez
  ];
}
