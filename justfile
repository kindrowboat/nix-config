rebuild:
    sudo nixos-rebuild switch --flake .

rebuild-emacs: rebuild
    $HOME/.emacs/bin/doom sync
