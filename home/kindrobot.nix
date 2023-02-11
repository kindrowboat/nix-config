{ config, home-manager, pkgs, ... }:
{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    age
    blender
    htop
    krita
    mosh
    neovim
    openscad
    pass
    silver-searcher
    prusa-slicer
    tmux
    vscode
    wget
  ];
  home.file.doom-d = {
    source = ./doom.d;
    target = ".doom.d";
  };
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];
  home.file.bin = {
    source = ./bin;
  };
  programs.direnv.enable = true;
  programs.git = {
    enable = true;
    userName = "Stef Dunlap";
    userEmail = "stef@kindrobot.ca";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      pkgs.mu
    ];
  };
  programs.command-not-found.enable = false;
  programs.fish.enable = true;
  programs.nix-index.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.75;
    };
  };
  programs.z-lua.enable = true;
  programs.ssh.enable = true;
  programs.ssh.extraConfig =
    ''
    # Turn CanonicalizeHostname on for Match to work below.
    CanonicalizeHostname yes
    
    # Defaults for all Wikimedia Foundation hosts.
    Match host=*.wikimedia.org,*.wmnet
        ForwardAgent no
        IdentitiesOnly yes
        KbdInteractiveAuthentication no
        PasswordAuthentication no
        User kindrobot
    
    # Configure the initial connection to the bastion host, with the one
    # HostName closest to you.
    Host bast
        HostName bast1003.wikimedia.org
        IdentityFile ~/.ssh/wmf_prod.key
        # In theory this User line shouldn't be necessary due to the Match above,
        # but in practice it seems to be.  In any case, it doesn't hurt.
        User kindrobot
    
    # Proxy all connections to internal servers through the bastion host.
    Host *.wmnet *.wikimedia.org !gerrit.wikimedia.org !bast*.wikimedia.org !gitlab.wikimedia.org
        ProxyJump bast
        IdentityFile ~/.ssh/wmf_prod.key
    
    # Configure direct connection to the bastion hosts.
    Host bast*.wikimedia.org
        IdentityFile ~/.ssh/wmf_prod.key
    
    Host gerrit.wikimedia.org
        Port 29418

    Host *.wmflabs.org *.wmcloud.org *.toolforge.org
        User kindrobot
    
    Host *.wmflabs *.wikimedia.cloud
        User kindrobot
        ProxyJump bastion.wmcloud.org:22
        SetEnv TERM=xterm-color
    
    Host town
    	Hostname tilde.town
    	User kindrobot
    	ForwardAgent yes
    Host team
    	Hostname tilde.team
    	User kindrobot
    	ForwardAgent yes
    '';
  services.kdeconnect = {
    enable = true;
  };
}

