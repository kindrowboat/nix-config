# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["module_blacklist=hid_sensor_hub" "i915.enable_psr=0"];
  boot.extraModulePackages = [ ];
  
  networking.hostName = "framework2";
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2c63d302-5165-4501-a2c3-f7d4c85c9e02";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/3AF6-0385";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.acpilight.enable = lib.mkDefault true;
  hardware.sensor.iio.enable = lib.mkDefault true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  services.fwupd.enable = true;
  hardware.bluetooth.enable = true;
  services.fprintd.enable = true;
  environment.systemPackages = with pkgs; [
    terminus_font
    pasystray
  ];
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };
  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    accelFactor = "0.075";
    fingersMap = [1 3 2 ];
    palmDetect = true;
    additionalOptions = ''
      Option "MaxTapTime" "150"
      Option "MaxTapMove" "25"

    '';
  };
}
