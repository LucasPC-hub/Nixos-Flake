{ config, pkgs, ... }:

{
  # Configuração de áudio com PipeWire
  # Suporte completo para ALSA e PulseAudio

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
    playerctl
  ];
}
