{ pkgs, ... }:
{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/laptop.cluster/192.168.1.10
    address=/revenge.jk/192.168.1.15
  '';
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://ku001.local:32000"
  '';

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
  ];
}
