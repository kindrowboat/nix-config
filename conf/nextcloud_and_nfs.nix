{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    dataDir = "/mnt/Inky/postgresql/";
  };
  services.nextcloud = {
    enable = true;
    datadir = "/mnt/Inky/nc_data";
    hostName = "nc.kindrobot.ca";
    https = true;
    config = {
      dbtype = "pgsql";
      dbpassFile = "/var/nextcloud-secrets/db_password.txt";
      adminuser = "admin";
      adminpassFile = "/var/nextcloud-secrets/admin_password.txt";
      overwriteProtocol = "https";
    };
  };
  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  # nfs setup
  fileSystems."/mnt/Gabriel" = {
    device = "/dev/disk/by-label/Gabriel";
    fsType = "exfat";
    options = ["nofail"];
  };
  fileSystems."/mnt/Henry" = {
    device = "/dev/disk/by-label/Henry";
    fsType = "exfat";
    options = ["nofail"];
  };
  fileSystems."/mnt/Isabela" = {
    device = "/dev/disk/by-label/Isabela";
    fsType = "exfat";
    options = ["nofail"];
  };
  fileSystems."/mnt/Inky" = {
    device = "/dev/disk/by-label/Inky";
    fsType = "ext4";
    options = ["nofail"];
  };
  fileSystems."/mnt/J" = {
    device = "/dev/disk/by-label/J";
    fsType = "ext4";
    options = ["nofail"];
  };
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt/Inky/nfs 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)
  '';
  networking.firewall.allowedTCPPorts = [
    8080 #nginx / nextcloud
    2049 #nfs
  ];
  services.nginx.virtualHosts."nc.kindrobot.ca".listen = [ { addr = "0.0.0.0"; port = 8080; } ];
}
