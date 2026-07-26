
{ pkgs, ... } : {
	environment.systemPackages = with pkgs;[
		helix
		nixd
		nixfmt
		taplo
	];
	xdg.configFiles."helix/languages.toml".source = ./helix/config.toml;
}
