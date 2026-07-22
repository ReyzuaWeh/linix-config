{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brave
    nixd
    nixfmt

    lazydocker
    #manager
    btop
    bemenu
    yazi
    micro
    #mount services
    udiskie
    #clipboard
    wl-clipboard
    cliphist
    #ss
    grim
    slurp
    #bright
    brightnessctl
    pamixer
    #notif
    mako
  ];
}
