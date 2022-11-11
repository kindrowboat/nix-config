{ pkgs, ... }:
{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/wiki.org/10.110.25.255
    address=/test.local/10.110.25.255
  '';
}
