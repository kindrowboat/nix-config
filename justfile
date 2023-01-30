rebuild:
    sudo nixos-rebuild switch --flake .

install-doom: link-org
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

link-org:
    ln -s $HOME/Nextcloud/org $HOME/org

rebuild-emacs: rebuild
    $HOME/.emacs.d/bin/doom sync
    systemctl --user restart emacs

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .
