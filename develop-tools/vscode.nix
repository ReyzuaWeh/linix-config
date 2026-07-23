{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    defaultEditor = true;
    extensions = with pkgs.vscode-extensions; [
      # Python & Java
      ms-python.python
      ms-python.vscode-pylance
      vscjava.vscode-java-pack

      # Web & Styling
      bradlc.vscode-tailwindcss
      samuelcolvin.jinjahtml

      # Tools & Git
      adpyke.codesnap
      github.vscode-pull-request-github

      # Nix
      jnoortheen.nix-ide
    ];
  };
}
