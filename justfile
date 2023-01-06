rebuild:
    sudo nixos-rebuild switch --flake .

install-doom:
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

rebuild-emacs: rebuild
    $HOME/.emacs.d/bin/doom sync
    systemctl --user restart emacs

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .
