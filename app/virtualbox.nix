{ pkgs, ... }:
{
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "kindrobot" ];

   environment.systemPackages = [
     pkgs.vagrant
   ];
}

