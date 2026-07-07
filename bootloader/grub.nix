{ pkgs, honkai-railway-grub-theme, ... }:

{
  boot.loader.grub = rec {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    theme = "${honkai-railway-grub-theme.packages.${pkgs.system}.evernight-grub-theme}";
    splashImage = "${theme}/background.png";
  };
 }
