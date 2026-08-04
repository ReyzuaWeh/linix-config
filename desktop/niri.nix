{ ... }: {
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.xwayland.enable = true;
  programs.foot.enable = true;
  programs.waybar.enable = true;
  services.gvfs.enable = true;
}
