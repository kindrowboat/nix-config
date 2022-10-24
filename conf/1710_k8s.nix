{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/laptop.cluster/192.168.1.10
  '';
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://ku001.local:32000"
  '';
}
