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

  networking.nameservers = [ "138.197.140.189" "38.103.195.4" ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.interception-tools = {
    enable = true;
    plugins = [pkgs.interception-tools-plugins.caps2esc];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
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
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "libvirtd" ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrBZ07LYJFTsQgnNJrScoTd8s7a1EcSBYlPUyLlh3FS stef@kindrobot.ca" ];
  };

  users.users.maxine = {
    isNormalUser = true;
    description = "Maxine";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiFgxifzUSUWhJoVNHhh3ymT2b3c4IsUkqApCddDph+ maxine@pat" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    barrier
    blender
    byobu
    chromium
    dig.dnsutils
    elinks
    fd
    firefox
    gh
    gimp
    git
    git-review
    gnome.gnome-boxes
    google-drive-ocamlfuse
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US
    hunspellDicts.fr-any
    hyfetch
    inkscape
    interception-tools
    kate
    keepassxc
    killall
    kubectl
    kubernetes-helm
    lbreakouthd
    libqalculate
    libreoffice-qt
    libsForQt5.sonnet
    mgba
    minikube
    ncdu
    neofetch
    neovim-qt
    nextcloud-client
    nix-tree
    obs-studio
    openstackclient
    parted
    python310
    python310Packages.pip
    qutebrowser
    remmina
    slack
    sops
    source-code-pro
    sshuttle
    tigervnc
    transmission
    transmission-gtk
    trash-cli
    tree
    unzip
    vivaldi
    vlc
    weechat
    xsel
    zoom-us
    zsh
  ];
  fonts.packages = with pkgs; [
    comic-mono
    fantasque-sans-mono
    nerdfonts
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = ["FantasqueSansMono Nerd Font Mono"];
  };
  environment.variables = {
    EDITOR = "nvim";
  };

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
    nssmdns4 = true;
    publish.enable = true;
    publish.addresses = true;
    publish.workstation = true;
  };
  services.openssh.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ] ;
    config.common.default = "*";
  };
  services.udisks2.enable = true;
  services.devmon.enable = true;
  programs.kdeconnect.enable = true;
  # Open ports in the firewall.
  networking.firewall = { 
    enable = true;
    allowedTCPPorts = [
      80
      443
      5900 # tigervnc
      8080 # web testing
      8081 # expo
      8888 # web testing
      24800 # barrier
      19000 # expo
    ];
    allowedUDPPortRanges = [
      { from = 60000; to = 61000; }
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

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  programs.virt-manager.enable = true;
  programs.nix-ld.enable = true;

  services.dnsmasq = {
    enable = true;
    settings = {
      address = [ "/.nowhere/192.168.49.2" ];
    };
  };

  networking.resolvconf.useLocalResolver = true;

}
