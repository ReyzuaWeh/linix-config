{ ... }: {
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "ReyzuaWeh";
        email = "ginanjar.alfarizi07@gmail.com";
      };
      init.defaultBranch = "main";
      core.editor = "nano";
    };
  };
}
