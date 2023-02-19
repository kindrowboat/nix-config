{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      #"kindrobot.ca, www.kindrobot.ca" = {
      #  extraConfig = ''
      #    redir https://tilde.town/~kindrobot{uri}
      #  '';
      #};
      "https://nc.kindrobot.ca:443" = { #, https://git.kindrobot.ca:443, https://files.kindrobot.ca:443" = {
        extraConfig = ''
	  header Strict-Transport-Security max-age=31536000;
	  reverse_proxy 192.168.1.20:8080
        '';
      };
      #"https://piepi.kindrobot.ca:443" = {
      #  serverAliases = [
      #    "https://xn--1xa9597w.to:443"
      #    "https://piepi.art:443"
      #  ];
      #  extraConfig = ''
      #    header Strict-Transport-Security max-age=31536000;
      #    reverse_proxy 192.168.1.110:80
      #  '';
      #};
    };
  };
}
