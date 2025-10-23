{ pkgs, config, lib, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = lib.mkForce "FantasqueSansM Nerd Font Mono Bold";
      size = lib.mkForce 12;
    };
    settings = {
      window_padding_width = 20;
      confirm_os_window_close = 0;

      linux_display_server = "auto";

      enable_audio_bell = false;

      font_features = "none";

      include = "dank-theme.conf";
    };
    
    keybindings = {
      # Scrolling
      "shift+up" = "scroll_line_up";
      "shift+down" = "scroll_line_down";
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "ctrl+shift+page_up" = "scroll_to_prompt -1";
      "ctrl+shift+page_down" = "scroll_to_prompt 1";
      "shift+home" = "scroll_home";
      "shift+end" = "scroll_end";
      
      # Copy/Paste
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      
      # Clear screen
      "ctrl+l" = "clear_terminal clear_active";
      
      # Interrupt signals
      "ctrl+alt+c" = "send_text all \\x03";
      "ctrl+backslash" = "send_text all \\x03";
      "ctrl+d" = "send_text all \\x03";
    };
  };
  
  # Optional: If you want to disable Stylix for kitty specifically
  # stylix.targets.kitty.enable = false;
}