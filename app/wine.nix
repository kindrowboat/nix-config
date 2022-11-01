{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wine
    playonlinux
  ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
