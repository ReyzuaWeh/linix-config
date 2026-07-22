{ ... }:
{
  programs.vscode.enable = true;
  programs.vscode.profiles.default.userSettings = {
    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
      "editor.formatOnSave" = true;
    };
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        "formattin" = {
          "command" = [ "nixfmt" ];
        };
        "options" = {
          "nixos" = {
            "expr" = "(builtins.getFlake \"/etc/nixos/\").nixosConfigurations.raj.options";
          };
        };
      };
    };
  };
}
