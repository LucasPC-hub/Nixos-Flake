{ config, pkgs, ... }:

{
  # Configuração de áudio com PipeWire
  # Suporte completo para ALSA e PulseAudio

  # PipeWire como servidor de áudio moderno
  services.pipewire = {
    enable = true;
    # Compatibilidade ALSA para aplicações nativas
    alsa.enable = true;
    # Suporte 32-bit para jogos e Wine
    alsa.support32Bit = true;
    # Emulação PulseAudio para apps legados
    pulse.enable = true;
  };

  # Ferramentas de controle de áudio
  environment.systemPackages = with pkgs; [
    pavucontrol  # Mixer gráfico PulseAudio
    pulseaudio   # Utilitários pactl
    playerctl    # Controle de players de mídia
  ];
}
