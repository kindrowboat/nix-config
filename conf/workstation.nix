{ config, pkgs, ... }:

{
  imports = [];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback.out
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:swapescape";

  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kindrobot = {
    isNormalUser = true;
    description = "Stef Dunlap";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrBZ07LYJFTsQgnNJrScoTd8s7a1EcSBYlPUyLlh3FS stef@kindrobot.ca" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks

    byobu
    chromium
    firefox
    gimp
    git
    git-review
    hunspell
    hunspellDicts.en_US
    hunspellDicts.en_CA
    hunspellDicts.fr-any
    inkscape
    kate
    killall
    python3Full
    qutebrowser
    remmina
    sops
    tigervnc
    trash-cli
    libreoffice-qt
    libsForQt5.sonnet
    tree
    unzip
    vlc
    xsel
    element-desktop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  programs.fish.enable = true;

  programs.command-not-found.enable = false;
  
  # List services that you want to enable:
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };
  services.openssh.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  # Open ports in the firewall.
  networking.firewall = { 
    enable = true;
    allowedTCPPorts = [
      24800 # barrier
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # kdeconnect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # kdeconnect
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
