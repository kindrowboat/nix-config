{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "kindrobot.ca" = {
        serverAliases = [
          "www.kindrobot.ca"
        ];
        extraConfig = ''
          redir https://tilde.town/~kindrobot{uri}
        '';
      };
      "meet.kindrobot.ca" = {
        extraConfig = ''
          redir https://meet.google.com/pwb-uvmn-imd
        '';
      };
      "https://nc.kindrobot.ca:443" = {
        extraConfig = ''
          header Strict-Transport-Security max-age=31536000;
          reverse_proxy 10.0.0.3:8080
        '';
      };
      "https://nc2.kindrobot.ca:443" = {
        extraConfig = ''
          header Strict-Transport-Security max-age=31536000;
          reverse_proxy 10.0.0.3:80
        '';
      };
      "https://git.kindrobot.ca:443" = {
        extraConfig = ''
	  header Strict-Transport-Security max-age=31536000;
	  reverse_proxy 10.0.0.3:80
        '';
      };
      "https://files.kindrobot.ca:443" = {
        extraConfig = ''
          header Strict-Transport-Security max-age=31536000;
          reverse_proxy 10.0.0.3:80
        '';
      };
      "https://piepi.kindrobot.ca:443" = {
        serverAliases = [
          "https://xn--1xa9597w.to:443"
          "https://piepi.art:443"
        ];
        extraConfig = ''
          header Strict-Transport-Security max-age=31536000;
          reverse_proxy 10.0.0.4:80
        '';
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
