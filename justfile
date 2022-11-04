rebuild:
    sudo nixos-rebuild switch --flake .

rebuild-emacs: rebuild
    $HOME/.emacs/bin/doom sync

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .
