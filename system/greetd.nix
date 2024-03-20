{ lib, pkgs, config, inputs, ... }:
{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    };
  };
}
