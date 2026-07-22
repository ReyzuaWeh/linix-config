{ ... }:
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;
  };
}
