{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config = {
      #common.default = "*";
      common = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal
    #  xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk

      # Niri
      xdg-desktop-portal-gnome
    ];
  };
}
