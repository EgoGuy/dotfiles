{ lib, pkgs, config, inputs, ... }:
{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
	command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --cmd river";
      };
    };
  };
}
