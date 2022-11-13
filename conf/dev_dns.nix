{ pkgs, ... }:
{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/test.local/10.110.25.255
    address=/wikifunctions.home/192.168.49.2
  '';
}
