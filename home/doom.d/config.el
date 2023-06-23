;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Stef Dunlap"
      user-mail-address "stef@kindrobot.ca")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq org-gcal-client-id "92451049096-2rg3qhs4t7gc8lu4rr88ftv4i6l54rgn.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      org-gcal-fetch-file-alist '(("apocryphalauthor@gmail.com" .  "~/org/personal.org")
                                  ("94tkuidkeh4c7ss1q0alhdq7ag@group.calendar.google.com" . "~/org/personal.org")))
(setq plstore-cache-passphrase-for-symmetric-encryption t)
(require 'org-gcal)

(after! mu4e
        (setq mail-user-agent             'mu4e-user-agent
        message-send-mail-function  'message-send-mail-with-sendmail
        sendmail-program            (executable-find "msmtp")
        mu4e-context-policy 'ask-if-none
        mu4e-compose-context-policy 'always-ask)

        (set-email-account! "stef"
        '((mu4e-sent-folder       . "/stef/Sent")
        (mu4e-drafts-folder     . "/stef/Drafts")
        (mu4e-trash-folder      . "/stef/Trash")
        (mu4e-refile-folder     . "/stef/Archives/2023")
        (mu4e-maildir-shortcuts . (("/stef/INBOX" . ?i)
                                ("/stef/Drafts"         . ?d)
                                ("/stef/Sent" . ?s)))
        (smtpmail-smtp-user     . "stef@kindrobot.ca")
        (user-mail-address      . "stef@kindrobot.ca")
        (user-full-name         . "Stef Dunlap")
        (mu4e-compose-signature . "Stef Dunlap (she/her)"))
        t)
        (set-email-account! "hello"
        '((mu4e-sent-folder       . "/hello/Sent")
        (mu4e-drafts-folder     . "/hello/Drafts")
        (mu4e-trash-folder      . "/hello/Trash")
        (mu4e-refile-folder     . "/hello/Archives/2023")
        (mu4e-maildir-shortcuts . (("/hello/INBOX" . ?i)
                                ("/hello/Drafts"         . ?d)
                                ("/hello/Sent" . ?s)))
        (smtpmail-smtp-user     . "hello@kindrobot.ca")
        (user-mail-address      . "hello@kindrobot.ca")
        (user-full-name         . "Stef Dunlap")
        (mu4e-compose-signature . "Stef Dunlap (she/her)"))
        t)
        (set-email-account! "team"
        '((mu4e-sent-folder       . "/team/Sent")
        (mu4e-drafts-folder     . "/team/Drafts")
        (mu4e-trash-folder      . "/team/Trash")
        (mu4e-refile-folder     . "/team/Archives/2023")
        (mu4e-maildir-shortcuts . (("/team/INBOX" . ?i)
                                ("/team/Drafts"         . ?d)
                                ("/team/Sent" . ?s)))
        (smtpmail-smtp-user     . "kindrobot@tilde.team")
        (user-mail-address      . "kindrobot@tilde.team")
        (user-full-name         . "Stef Dunlap")
        (mu4e-compose-signature . "Stef Dunlap (she/her)"))
        t)
        (set-email-account! "gmail"
        '((mu4e-sent-folder       . "/gmail/Sent")
        (mu4e-drafts-folder     . "/gmail/Drafts")
        (mu4e-trash-folder      . "/gmail/Trash")
        (mu4e-refile-folder     . "/gmail/Archives/2023")
        (mu4e-maildir-shortcuts . (("/gmail/INBOX" . ?i)
                                ("/gmail/Drafts"         . ?d)
                                ("/gmail/Sent" . ?s)))
        (smtpmail-smtp-user     . "apocryphalauthor@gmail.com")
        (user-mail-address      . "apocryphalauthor@gmail.com")
        (user-full-name         . "Stef Dunlap")
        (mu4e-compose-signature . "Stef Dunlap (she/her)"))
        t)
)
(after! org
        (super-save-mode +1))

(add-hook 'text-mode-hook 'auto-save-visited-mode)
