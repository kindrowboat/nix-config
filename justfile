rebuild:
    sudo nixos-rebuild switch --flake .

install-doom: clone-org
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

clone-org:
    git clone git@gitlab.com:motevets/org ~/org

rebuild-emacs: rebuild
    $HOME/.emacs.d/bin/doom sync
    systemctl --user restart emacs

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .
