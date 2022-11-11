rebuild:
    sudo nixos-rebuild switch --flake .

rebuild-emacs: rebuild
    $HOME/.emacs.d/bin/doom sync
    systemctl --user restart emacs

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .
