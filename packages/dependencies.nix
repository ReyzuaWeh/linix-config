{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
  environment.systemPackages = with pkgs; [
    microsoft-edge
    brave

    xwayland-satellite
    lazydocker
    fuzzel
    #manager
    btop
    bemenu
    yazi
    micro
    #mount services
    # udiskie
    #clipboard
    wl-clipboard
    cliphist
    #ss
    # grim
    # slurp
    #bright
    brightnessctl
    pamixer
    #notif
    mako
  ];
}
